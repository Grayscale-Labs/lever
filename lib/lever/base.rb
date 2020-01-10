require 'hashie'

module Lever
  class Base < Hashie::Trash
    include Hashie::Extensions::IndifferentAccess
    property :client

    def fetch(method, id)
      client.send(method.to_sym, id: id)
    end
  end
end