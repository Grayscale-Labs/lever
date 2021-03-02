# frozen_string_literal: true

require 'lever/opportunity'
require 'lever/resource_collection'

module Lever
  class OpportunityCollection < ResourceCollection
    def initialize(*args, **kw_args)
      kw_args.merge!(resource_class: Opportunity)
      super
    end
  end
end
