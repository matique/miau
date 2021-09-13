require "test_helper"

describe Miau, "storage" do
  let(:storage) { Miau::PolicyStorage.instance }
  let(:user) { "User" }
  let(:post) { Post.new(user, 1) }
  let(:params) { {action: "update", controller: "posts"} }
  let(:posts_controller) { PostsController.new(user, params) }

  def test_run
    result = storage.run :Posts, :update, user, nil
    assert result
  end
end
