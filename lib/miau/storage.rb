# frozen_string_literal: true

require "singleton"

module Miau
  class PolicyStorage
    include Singleton

    attr_reader :policies

    def initialize
      @policies = {}
    end

    def run(klass, action, user, resource)
      policy = policy(klass, user, resource)
      return policy.send(action) if policy.respond_to?(action)

      msg = "class <#{klass} action <#{action}>"
      raise Miau::NotDefinedError, msg
    end

    private

    def policy(klass, user, resource)
      result = @policies[klass]
      if result
        result.user = user
        result.resource = resource
        return result
      end

      create_policy(klass, user, resource)
    end

    def create_policy(klass, user, resource)
      str = "#{klass}Policy"
      result = str.constantize.new(user, resource)
      @policies[klass] = result
    end
  end
end
