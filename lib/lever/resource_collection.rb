# frozen_string_literal: true

require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

module Lever
  # This class does lazy pagination, but otherwise quacks like an Array by delegating method calls to
  #   its `hydrated_resources` internal Array.
  #
  # Lazy pagination allows for (e.g.):
  #   `collection.each.with_index { |resource, i| puts resource.id; break if i == 0; }`
  #
  #   That ^^ will only request the first page, regardless of whether subsequent pages exist or not.
  #
  # Note, however, that if a non-Enum Array method is used (e.g. #[], #length) and full pagination hasn't been done yet,
  #   pagination is first done to completion before delegating the method call to the internal Array.
  class ResourceCollection
    include Enumerable

    attr_accessor :client, :query_params, :resource_class, :dehydrate_after_iteration

    def initialize(client:, query_params: {}, resource_class:, dehydrate_after_iteration: true)
      self.client             = client
      self.query_params       = query_params
      self.resource_class     = resource_class # e.g. Lever::Opportunity
      self.hydrated_resources = []
      self.dehydrate_after_iteration = dehydrate_after_iteration
    end

    def each
      return enum_for(:each) unless block_given?

      i = 0
      loop do
        if hydrated_resources.length == i
          num_added_resources = request_next_page!
          break if num_added_resources.zero?
        end

        yield hydrated_resources[i]
        hydrated_resources[i] = :dehydrated if dehydrate_after_iteration
        i += 1
      end

      hydrated_resources
    end

    # Array#count is more efficient than Enum#count, so we want to utilize it if pagination has already been done to
    #   completion
    def count(*args, &block)
      return super unless all_pages_requested?

      hydrated_resources.count(*args, &block)
    end

    def method_missing(method, *args, &block)
      if hydrated_resources.respond_to?(method)
        each() { } unless all_pages_requested? # force a full hydration
        return hydrated_resources.public_send(method, *args, &block)
      end

      super
    end

    def respond_to_missing?(method, __include_private = false)
      hydrated_resources.respond_to?(method) || super
    end

    private

    attr_accessor :hydrated_resources, :next_offset, :all_pages_requested

    # returns # of new resources
    def request_next_page!
      return 0 if all_pages_requested?

      query_params.merge!(offset: next_offset) if next_offset.present?

      # TODO: have lower-level methods (e.g. #get_resource) implement retries
      resp_arr = client.with_retries do
        client.get_resource(
          Lever::Client::BASE_PATHS[resource_class.name.demodulize.tableize.to_sym], # e.g. '/opportunities'
          resource_class,                                                            # e.g. Lever::Opportunity
          nil,
          query: query_params
        ) do |response|
          self.next_offset         = response['next']
          self.all_pages_requested = !response['hasNext']
        end
      end

      hydrated_resources.push(*resp_arr)

      resp_arr.length
    end

    def all_pages_requested?
      !!all_pages_requested
    end
  end
end
