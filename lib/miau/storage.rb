# frozen_string_literal: true

require "singleton"
require 'active_support/inflector'

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
      @instances[kls] ||= klass.new
      @policies[kls][action.to_sym] = meth.to_sym
    end

    def run(klass, action, user, resource)
ic "RUN"
#ic 11, klass, action, user, resource
      klass = klass.to_sym
      action = action.to_sym
ic @instances[klass]
      p = @instances[klass] ||= "#{klass.camelcase}Policy".constantize.new
      policy = p
ic policy
      policy.user = user
      policy.resource = resource
ic policy
p 11
      return policy.send(action) if policy.respond_to?(action)

x = @policies[klass][action]
ic x
p 22
      return policy.send(x) if policy.respond_to?(x)

      msg = "class <#{klass} action <#{action}>"
      raise Miau::NotDefinedError, msg
    end

    def to_yaml
      "# === @policies ===\n" + YAML.dump(@policies) +
      "# === @instances ===\n" + YAML.dump(@instances)
    end
  end
end
