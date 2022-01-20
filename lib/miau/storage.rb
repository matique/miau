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

    # return instance of policy (may be nil) and the method
    # klass and action are symbols
    # Priority:
    #   - method of <klass>Policy
    #   - method of <klass>Policy specified by "miau action, method"
    #   - method of ApplicationPolicy (independent of klass)
    #   - method of ApplicationPolicy specified by "miau action, method"
    #   - nil
    def responder(klass, action)
ic "responder"
ic 11, klass, action
      kls = "#{klass.to_s.camelcase}Policy"
ic kls
      policy = @instances[klass] ||= kls.constantize.new
      return policy if policy.respond_to?(action)

p 11
act = @policies[klass][action]
      return policy if policy.respond_to?(act)
p 22
klass = :application
      policy = @instances[:application]
      return policy if policy.respond_to?(action)

act = @policies[:application][action]
      return policy if policy.respond_to?(act)

return nil


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
      return policy.send(x) if x && policy.respond_to?(x)

i = @instances[:application]
ic i
p = @policies[:application]
ic p
      msg = "class <#{klass} action <#{action}>"
      raise Miau::NotDefinedError, msg
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
      return policy.send(x) if x && policy.respond_to?(x)

i = @instances[:application]
ic i
p = @policies[:application]
ic p
      msg = "class <#{klass} action <#{action}>"
      raise Miau::NotDefinedError, msg
    end

    def to_yaml
      "# === @policies ===\n" + YAML.dump(@policies) +
      "# === @instances ===\n" + YAML.dump(@instances)
    end

    private

    def undefined(klass, action)
      msg = "class <#{klass} action <#{action}>"
      raise Miau::NotDefinedError, msg
    end
  end
end
