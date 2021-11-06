# frozen_string_literal: true

module Miau
  class Error < StandardError; end

  class NotAuthorizedError < Error
    attr_reader :controller, :query, :policy

    def initialize(options = {})
      if options.is_a? String
        message = options
      else
        @controller = options[:controller]
        @query = options[:query]
        @policy = options[:policy]

        message = options.fetch(:message) { "not allowed to #{query} of #{controller} by #{policy.inspect}" }
      end

      super(message)
    end
  end

  class NotDefinedError < Error
  end

  class AuthorizationNotPerformedError < Error
  end
end
