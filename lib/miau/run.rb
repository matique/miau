# frozen_string_literal: true

require "singleton"
require "yaml"

module Miau
  class PolicyRun
    include Singleton

    # return instance of policy (may be nil) and the method
    # klass and action are symbols
    # Priority:
    #   - method of <klass>Policy
    #   - method of <klass>Policy specified by "miau action, method"
    #   - method of ApplicationPolicy (independent of klass)
    #   - method of ApplicationPolicy specified by "miau action, method"
    #   - nil
    # returns policy: [instance, method]
    def find_policy(klass, action)
      kls = instance_of(klass)
      act = policy_method(klass, action)
      return [kls, act] if kls.respond_to?(act)

      klass = :application
      kls = instance_of(klass)
      act = policy_method(klass, action)
      [kls, act] if kls.respond_to?(act)
    end

    def run(klass, action, user, resource)
      arr = find_policy(klass, action)
      unless arr
        msg = "class <#{klass}> action <#{action}>"
        raise Miau::NotDefinedError, msg
      end

      policy, meth = arr
      policy.user = user
      policy.resource = resource
      [meth].flatten.each { |m|
        return false unless policy.send(m)
      }
      true
    end

    private

    def instance_of(klass)
      res = Miau::PolicyStorage.instance.instances[klass]
      return res if res

      name = "#{klass.to_s.camelcase}Policy"
      return nil unless Object.const_defined?(name)

      Miau::PolicyStorage.instance.instances[klass] = name.constantize.new
    end

    def policy_method(klass, action)
      act = Miau::PolicyStorage.instance.policies[klass]
      return action unless act

      act[action] || action
    end
  end
end
