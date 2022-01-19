# frozen_string_literal: true

require "singleton"

module Miau
  class PolicyStorage
    include Singleton

    # Example @policies:
    # {
    #   posts: {
    #     index: :index,
    #     show: :show,
    #     delete: :delete,
    #     remove: :delete"
    #   },
    #   application: {
    #     admin: :admin
    #   }
    # }
    attr_reader :policies
    attr_reader :instances # { posts: PostsPolicy.new }

    def initialize
      reset
    end

    def reset
      @policies = {}
      @instances = {}
    end

    def add(klass, action, meth)
#ic klass, action, meth
      kls = klass.name.underscore[0 .. -8] # remove "_policy"
      kls = kls.to_sym
      @policies[kls] ||= {}
      @instances[kls] = klass.new(nil, nil) unless @instances[kls]
      @policies[kls][action.to_sym] = meth.to_sym
    end

    def run(klass, action, user, resource)
#ic 11, klass, user, resource
      policy = policy(klass, user, resource)
      return policy.send(action) if policy.respond_to?(action)

      msg = "class <#{klass} action <#{action}>"
      raise Miau::NotDefinedError, msg
    end

    def to_yaml
      "# === @policies ===\n" + YAML.dump(@policies) +
      "# === @instances ===\n" + YAML.dump(@instances)
    end

    private

    def policy(klass, user, resource)
#ic klass, user, resource
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
