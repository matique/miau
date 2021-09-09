require "test_helper"

describe Miau do
  let(:user) { "User" }
  let(:post) { Post.new(user, 1) }
  let(:params) { {action: "update", controller: "posts"} }
  let(:posts_controller) { PostsController.new(user, params) }

  def test_miau_user_same_as_current_user
    assert_equal posts_controller.miau_user, posts_controller.current_user
  end
end
