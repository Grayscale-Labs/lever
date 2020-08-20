module Lever
  class Error < StandardError
    def initialize(message, code = nil)
      super(message)
      @code = code
    end
  end

  class InvalidRequestError < Error; end;
  class UnauthorizedError < Error; end;
  class ForbiddenError < Error; end;
  class NotFoundError < Error; end;
  class TooManyRequestsError < Error; end;
  class ServerError < Error; end;
  class ServiceUnavailableError < Error; end;
end
