require "test_helper"

describe Miau, "controller" do
  let(:user) { "User" }
  let(:post) { Post.new(user, 1) }
  let(:params) { {action: "si", controller: "posts"} }
  let(:posts_controller) { PostsController.new(user, params) }

#  def test_authorize_controller!
#    refute posts_controller.authorize_controller!
#  end

  def test_authorized_controller?
    assert posts_controller.authorized_controller?
  end
end
