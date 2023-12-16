# frozen_string_literal: true

class ApplicationPolicy
  attr_accessor :user, :resource

  def self.miau(actions, meth = nil, &block)
    kls = self.name.underscore[0..-8] # remove "_policy"
    [actions].flatten.each { |action|
ic 33, kls, action, meth
      Miau::PolicyStorage.instance.add_policy(kls, action, meth)
    }
  end
end
