require "test_helper"

describe Miau, "performed authorization" do
  let(:user) { "User" }
  let(:post) { Post.new(user, 1) }
  let(:params) { {action: "si", controller: "posts"} }
  let(:posts_controller) { PostsController.new(user, params) }

  def test_does_nothing_when_authorized
    posts_controller.authorize!(post)
    posts_controller.verify_authorized
  end

  def test_exception_when_not_authorized
    assert_raises(Miau::AuthorizationNotPerformedError) {
      posts_controller.verify_authorized
    }
  end

  def test_skip_authorization
    posts_controller.skip_authorization
    posts_controller.verify_authorized
  end

  def test_authorization_performed
    posts_controller.authorize!(post)
    assert posts_controller.miau_authorization_performed?
  end

  def test_authorization_not_performed
    refute posts_controller.miau_authorization_performed?
  end

  def xtest_authorize_controller!
    refute posts_controller.authorize_controller!
  end

  def test_authorize_controller?
    assert posts_controller.authorize_controller?
  end
end
