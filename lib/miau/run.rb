# frozen_string_literal: true

require "singleton"
require "yaml"

module Miau
  class PolicyRun
    include Singleton

    # return method[s]
    # klass and action are symbols
    # Priority:
    #   - method of <klass>Policy
    #   - method of <klass>Policy specified by "miau action, method"
    #   - method of ApplicationPolicy (independent of klass)
    #   - method of ApplicationPolicy specified by "miau action, method"
    #   - nil
    # returns method_name[s]

    def find_methods(policy, klass, action)
      return action if policy.respond_to?(action)

      hsh = PolicyStorage.instance.policies[klass]
      return nil unless hsh

      hsh[action]
    end

    def runs(policy, actions)
      [actions].flatten.each { |action|
        raise_undef(policy, action) unless policy&.respond_to?(action)

        return false unless policy.send(action)
      }
      true
    end

    def raise_undef(policy, action)
      msg = "policy <#{policy}> action <#{action}>"
      raise NotDefinedError, msg
    end

    def raise_authorize(controller, action)
      msg = "controller <#{controller}> action <#{action}>"
      raise NotAuthorizedError, msg
    end
  end
end
