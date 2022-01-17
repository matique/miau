# frozen_string_literal: true

require "singleton"

module Miau
  class PolicyStorage
    include Singleton

    # Example:
    # {
    #   "posts" => {
    #     "index" => [posts_policy, "index"],
    #     "show" => [posts_policy, "show"].
    #     "delete" => [application_policy, "delete"]
    #     "remove" => [application_policy, "delete"]
    #   },
    #   "application" => {
    #     "admin" => [application_policy, "admin"]
    #   }
    # }
    attr_reader :policies

    def initialize
      reset
    end

    def reset
      @policies = {}
    end

def add(klass, action, meth)
ic klass, action, meth
  @policies[klass] ||= {}
  @policies[klass][action] = meth
#  @policies[klass] << [action, meth]
end

    def run(klass, action, user, resource)
ic 11, klass, user, resource
      policy = policy(klass, user, resource)
      return policy.send(action) if policy.respond_to?(action)

      msg = "class <#{klass} action <#{action}>"
      raise Miau::NotDefinedError, msg
    end

    def to_yaml
      "# === @policies ===\n" + YAML.dump(@policies)
    end

    private

    def policy(klass, user, resource)
ic klass, user, resource
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
