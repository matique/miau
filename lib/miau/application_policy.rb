# frozen_string_literal: true

class ApplicationPolicy
  attr_accessor :user, :resource

  def self.miau(actions, meth = nil, &block)
    [actions].flatten.each { |action|
      Miau::PolicyStorage.instance.add(self, action, meth)
    }
  end
end
