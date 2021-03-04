# frozen_string_literal: true

require 'lever/stage'
require 'lever/resource_collection'

module Lever
  class StageCollection < ResourceCollection
    def initialize(*args, **kw_args)
      kw_args.merge!(resource_class: Stage)
      super
    end
  end
end
