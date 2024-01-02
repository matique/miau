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

describe Miau, "controller" do
  let(:user) { "User" }

  def test_authorize_controller!
    params = {controller: "posts"}
    posts_controller = PostsController.new(user, params)
    refute posts_controller.authorize_controller!
  end

  def test_authorize_controller_not_defined
    params = {controller: "not"}
    not_controller = NotController.new(user, params)
    assert_raises (Miau::NotDefinedError) {
      not_controller.authorize_controller!
    }
  end
end
