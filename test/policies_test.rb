require "test_helper"
require "miau/application_policy"

class ApplicationPolicy
  miau %i[show edit], :bar

  def bar
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
#ic str
puts str
    posts_controller.authorize!(post, policy: nil, action: :action)
  end
end
