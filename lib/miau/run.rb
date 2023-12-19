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
    # returns [klass, method]
    def find_policy(kls, action)
      name = "#{kls.to_s.camelcase}Policy"
ic 990, name
    if Object.const_defined?(name)
ic 991
      klass = name.constantize.new
ic 9911, klass
      return [klass.class, action] if klass.respond_to?(action)
p 992
      hsh = Miau::PolicyStorage.instance.policies[kls]
      if hsh
        meth = hsh[action]
        return [klass.class, meth] if meth
      end
      hsh = Miau::PolicyStorage.instance.policies[:application]
      if hsh
        meth = hsh[action]
#        return [ApplicationPolicy.class, meth] if meth
        return [ApplicationPolicy, meth] if meth
      end
ic 993
#raise
    end
    return nil
raise
#klass = name.constantize.new
#klass = name.constantize
#ic 993, klass
#return [klass, action]
#      act = Miau::PolicyStorage.instance.policies[klass]
#      return action unless act
#
#      act[action] || action
    end

    def run(klass, action, user, resource)
      policy = Miau::PolicyStorage.instance.find_or_create(klass)
      meth = find_policy(klass, action)
      unless meth
        msg = "class <#{klass}> action <#{action}>"
        raise Miau::NotDefinedError, msg
      end

      policy.user = user
      policy.resource = resource
      [meth].flatten.each { |m|
        return false unless policy.send(m)
      }
      true
    end
  end
end
