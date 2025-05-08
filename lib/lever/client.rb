# frozen_string_literal: true

require 'lever/application'
require 'lever/archive_reason'
require 'lever/interview'
require 'lever/opportunity_collection'
require 'lever/posting'
require 'lever/stage_collection'
require 'lever/user'

require 'lever/error'

require 'httparty'
require 'retriable'

module Lever
  class Client
    include HTTParty

    BASE_PATHS = {
      opportunities: '/opportunities',
      stages:        '/stages'
    }

    attr_accessor :base_uri
    attr_reader :options

    def initialize(token, options = {})
      if options[:sandbox]
        @base_uri = 'https://api.sandbox.lever.co/v1'
      else
        @base_uri = 'https://api.lever.co/v1'
      end

      @options = { basic_auth: { username: token } }

      if options[:headers]
        @options[:headers] = options[:headers]
      end
    end

    def users(id: nil, on_error: nil)
      get_resource('/users', Lever::User, id, { on_error: on_error })
    end

    def opportunities(id: nil, contact_id: nil, on_error: nil, return_opportunity_collection: false, **query_params)
      # Here we're taking the first step in a larger journey to allow methods like this to return a `ResourceCollection`
      #
      # To start, we aim not to change current expected usage. The scenarios are:
      # client.opportunities                            # returns an Array of Lever::Opportunity objects (unchanged)
      # client.opportunities(contact_id: 123)           # returns an Array of Lever::Opportunity objects (unchanged)
      # client.opportunities(id: 456)                   # returns a Lever::Opportunity (unchanged)
      # client.opportunities(id: 456, contact_id: 123)  # returns a Lever::Opportunity (unchanged)
      # client.opportunities(return_opportunity_collection: true) # returns a Lever::OpportunityCollection (this is new)
      # client.opportunities(some: :param_val)                    # returns a Lever::OpportunityCollection (this is new)
      # client.opportunities(contact_id: 123, some: :param_val)           # contact_id will be added to query_params
      # client.opportunities(id: 456, on_error: [proc], some: :param_val) # raises an error (mixing old/new interfaces)
      #
      if query_params.any? || return_opportunity_collection
        if [id, on_error].compact.any?
          raise Lever::Error, "`Lever::Client#opportunities`'s new interface for returning an OpportunityCollection "\
                              "does not allow for `id:` or `on_error:` keyword args"
        end
        query_params.merge!(contact_id: contact_id) unless contact_id.nil?

        return Lever::OpportunityCollection.new(client: self, query_params: query_params)
      end

      query = if id
        'expand=applications&expand=stage'
      else
        contact_id ? { contact_id: contact_id } : {}
      end

      get_resource(
        BASE_PATHS[__method__],
        Lever::Opportunity,
        id,
        { query: query, on_error: on_error }
      )
    end

    def interviews(opportunity_id:, id: nil)
      get_resource("/opportunities/#{opportunity_id}/interviews", Lever::Interview, id)
    end

    def stages(id: nil, on_error: nil, return_stage_collection: false, **query_params)
      # Here we're taking the first step in a larger journey to allow methods like this to return a `ResourceCollection`
      #
      # To start, we aim not to change current expected usage. The scenarios are:
      # client.stages                   # returns an Array of Lever::Stage objects (unchanged)
      # client.stages(id: 123)          # returns a Lever::Stage (unchanged)
      # client.stages(return_stage_collection: true) # returns a Lever::StageCollection (this is new)
      # client.stages(some: :param_val)              # returns a Lever::StageCollection (this is new)
      # client.opportunities(id: 123, on_error: [proc], some: :param_val) # raises an error (mixing old/new interfaces)
      #
      if query_params.any? || return_stage_collection
        if [id, on_error].compact.any?
          raise Lever::Error, "`Lever::Client#stages`'s new interface for returning a StageCollection "\
                              "does not allow for `id:` or `on_error:` keyword args"
        end

        return Lever::StageCollection.new(client: self, query_params: query_params)
      end

      get_resource(BASE_PATHS[__method__], Lever::Stage, id, { on_error: on_error })
    end

    def postings(id: nil, on_error: nil)
      get_resource('/postings', Lever::Posting, id, { on_error: on_error })
    end

    def archive_reasons(id: nil, on_error: nil)
      get_resource('/archive_reasons', Lever::ArchiveReason, id, { on_error: on_error })
    end

    def hired_archive_reasons(on_error: nil)
      get_resource('/archive_reasons', Lever::ArchiveReason, nil, { on_error: on_error, query: { type: 'hired' } })
    end

    def add_note(opportunity_id, body, raise_http_errors: false)
      post_resource("/opportunities/#{opportunity_id}/notes", { value: body }, raise_http_errors: raise_http_errors)
    end

    def post_resource(path, body, raise_http_errors: false)
      response = begin
        self.class.post("#{base_uri}#{path}", @options.merge({ body: body }))
      rescue EOFError => err
        raise Lever::ServiceUnavailableError.new(err.message)
      end

      # to preserve backward compatibilty, raising errors is disabled by default
      # omit the optional raise_http_errors flag to retain the legacy behavior
      if response.success? || !raise_http_errors
        response.parsed_response
      else
        error = case response.code
                when 400
                  Lever::InvalidRequestError
                when 401
                  Lever::UnauthorizedError
                when 403
                  Lever::ForbiddenError
                when 404
                  Lever::NotFoundError
                when 429
                  Lever::TooManyRequestsError
                when 500
                  Lever::ServerError
                when 503
                  Lever::ServiceUnavailableError
                else
                  Lever::Error
                end

        raise error.new(response.code, response.code)
      end
    end

    def with_retries
      return yield if using_with_retries

      begin
        # Eventually we want to have lower-level methods like #get_resource implement retries automatically
        # So let's disallow nested `with_retries` blocks just in case we add it there but forget to remove it from
        #   higher-level methods
        self.using_with_retries = true

        Retriable.retriable(on: [Lever::TooManyRequestsError, Lever::ServerError, Lever::ServiceUnavailableError]) do
          yield
        end
      ensure
        self.using_with_retries = false
      end
    end

    def get_resource(base_path, objekt, id = nil, options = {})
      path = id.nil? ? base_path : "#{base_path}/#{id}"

      add_query = options[:query]
      on_error = options[:on_error]

      response = begin
        self.class.get("#{base_uri}#{path}", @options.merge(query: add_query))
      rescue EOFError => err
        raise Lever::ServiceUnavailableError.new(err.message)
      end
      if response.success?
        parsed_response = response.parsed_response

        yield parsed_response if block_given?

        include_properties = { client: self }

        if id
          objekt.new(parsed_response.dig('data').merge(include_properties))
        else
          parsed_response.dig('data').map do |hash|
            objekt.new(hash.merge(include_properties))
          end
        end
      else
        if on_error
          on_error.call(response)
        else
          error = case response.code
                  when 400
                    Lever::InvalidRequestError
                  when 401
                    Lever::UnauthorizedError
                  when 403
                    Lever::ForbiddenError
                  when 404
                    Lever::NotFoundError
                  when 429
                    Lever::TooManyRequestsError
                  when 500
                    Lever::ServerError
                  when 503
                    Lever::ServiceUnavailableError
                  else
                    Lever::Error
                  end

          raise error.new(response.code, response.code)
        end
      end
    end

    private

    attr_accessor :using_with_retries # see #with_retries
  end
end

