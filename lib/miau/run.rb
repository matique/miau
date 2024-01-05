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

#    def find_policy(kls, action)
#      name = "#{kls.to_s.camelcase}Policy"
#      if Object.const_defined?(name)
#        klass = name.constantize.new
#        return action if klass.respond_to?(action)
#
#        hsh = PolicyStorage.instance.policies[kls]
#        if hsh
#          meth = hsh[action]
#          return meth if meth
#        end
#        hsh = PolicyStorage.instance.policies[:application]
#        if hsh
#          meth = hsh[action]
#          return meth if meth
#        end
#      end
#
#      nil
#    end

    def find_policy(policy, klass, action)
#ic policy, klass, action
      return action if policy.respond_to?(action)

      hsh = PolicyStorage.instance.policies[klass]
#ic hsh
      return nil unless hsh

      hsh[action]
    end

    def run(klass, action, user, resource)
#ic :run, klass, action, user, resource
      policy = PolicyStorage.instance.find_or_create_policy(klass)
      meth = find_policy policy, klass, action if policy
      meth ||= find_policy ApplicationPolicy, :application, action
#ic meth

      unless meth
        msg = "class <#{klass}> action <#{action}>"
        raise NotDefinedError, msg
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
