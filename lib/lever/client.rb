require 'httparty'

# TODO: Add pagination (lever limits to 100)

module Lever
  class Client
    include HTTParty

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

    def opportunities(id: nil, contact_id: nil, on_error: nil)
      query = if id
        'expand=applications&expand=stage'
      else
        contact_id ? { contact_id: contact_id } : {}
      end

      get_resource(
        '/opportunities',
        Lever::Opportunity,
        id,
        { query: query, on_error: on_error }
      )
    end

    def interviews(opportunity_id:, id: nil)
      get_resource("/opportunities/#{opportunity_id}/interviews", Lever::Interview, id)
    end

    def stages(id: nil, on_error: nil)
      get_resource('/stages', Lever::Stage, id, { on_error: on_error })
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

    def add_note(opportunity_id, body)
      post_resource("/opportunities/#{opportunity_id}/notes", { value: body })
    end

    def post_resource(path, body)
      response = self.class.post("#{base_uri}#{path}", @options.merge({ body: body }))

      response.parsed_response
    end

    def get_resource(base_path, objekt, id = nil, options = {})
      path = id.nil? ? base_path : "#{base_path}/#{id}"

      add_query = options[:query]
      on_error = options[:on_error]

      response = self.class.get("#{base_uri}#{path}", @options.merge({ query: add_query }))
      if response.success?
        include_properties = { client: self }

        if id
          objekt.new(response.parsed_response.dig('data').merge(include_properties))
        else
          response.parsed_response.dig('data').map do |hash|
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
  end
end

