# frozen_string_literal: true

module Miau
  class Error < StandardError; end

  class NotAuthorizedError < Error
  end

  class NotDefinedError < Error
  end

  class AuthorizationNotPerformedError < Error
  end
end
