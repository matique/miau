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
    # returns method_name[s]

    def find_policy(policy, klass, action)
      return action if policy.respond_to?(action)

      hsh = PolicyStorage.instance.policies[klass]
      return nil unless hsh

      hsh[action]
    end

    def run(klass, action, user, resource)
      policy = PolicyStorage.instance.find_or_create_policy(klass)
      meth = find_policy policy, klass, action if policy
      meth ||= find_policy ApplicationPolicy, :application, action

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
