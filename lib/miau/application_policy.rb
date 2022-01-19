# frozen_string_literal: true

class ApplicationPolicy
  attr_accessor :user, :resource

  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  def self.miau(actions, meth = nil, &block)
#ic actions, meth, block
    [actions].flatten.each { |action|
      Miau::PolicyStorage.instance.add(self, action, meth)
    }
  end
end
