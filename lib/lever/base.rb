require 'hashie'

module Lever
  class Base < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::IndifferentAccess
    property :client

    def fetch(method, id)
      client.send(method.to_sym, id: id)
    end

    def hired_archive_reason?(reason_id)
      client.hired_archive_reasons.map(&:id).include?(reason_id)
    rescue Lever::ForbiddenError
      false
    end
  end
end
