require "test_helper"

class NotController
  include Miau

  attr_accessor :current_user, :params

  def initialize(current_user, params = {})
    @current_user = current_user
    @params = params
  end
end

class NotPolicy < ApplicationPolicy
end

class FalseController
  include Miau

  attr_accessor :current_user, :params

  def initialize(current_user, params = {})
    @current_user = current_user
    @params = params
  end
end

class FalsePolicy < ApplicationPolicy
  def controller
    false
  end
end

describe Miau, "controller" do
  let(:user) { "User" }

  def test_unknown_policy
    params = {controller: "unknown", action: :any}
    posts_controller = PostsController.new(user, params)
    assert_raises(Miau::NotDefinedError) {
      posts_controller.authorize_controller!
    }
  end

  def test_authorize_controller!
    params = {controller: "posts", action: :any}
    posts_controller = PostsController.new(user, params)
    posts_controller.authorize_controller!
  end

  def test_authorize_controller_not_defined
    params = {controller: "not", action: :any}
    not_controller = NotController.new(user, params)
    assert_raises(Miau::NotDefinedError) {
      not_controller.authorize_controller!
    }
  end

  def test_authorize_controller_false
    params = {controller: "false", action: :any}
    false_controller = FalseController.new(user, params)
    assert_raises(Miau::NotAuthorizedError) {
      false_controller.authorize_controller!
    }
  end
end
