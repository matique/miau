require "test_helper"
require "miau/application_policy"

class ApplicationPolicy
  miau %i[show edit], :bar2

  def bar2
ic "bar"
ic user, resource
    true
  end
end

describe ApplicationPolicy do
  let(:user) { "User" }
  let(:post) { Post.new(user, 1) }
  let(:params) { {action: "update", controller: "posts"} }
  let(:posts_controller) { PostsController.new(user, params) }
  let(:storage) { Miau::PolicyStorage.instance }

  def test_x
str = storage.to_yaml
puts str
p 11111111111111
    posts_controller.authorize!
  end

  def test_y
p 22222222222222
    posts_controller.authorize!(post, action: :show)
  end

  def test_z
p 3333333333333
    posts_controller.authorize!(post, action: :edit)
  end
end
