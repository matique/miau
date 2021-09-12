require "test_helper"

describe Miau do
  let(:user) { "User" }
  let(:post) { Post.new(user, 1) }
  let(:params) { {action: "update", controller: "posts"} }
  let(:posts_controller) { PostsController.new(user, params) }

  describe "#authorize!" do
    def test_ok_no_raise
      posts_controller.authorize!(post)
    end

    def test_return_false
      posts_controller.params[:action] = "destroy"
      assert_raises(Miau::NotAuthorizedError) {
        posts_controller.authorize!(post)
      }
    end

    def test_NotDefinedError
      posts_controller.params[:controller] = "articles"
      # assert_raises(Miau::NotDefinedError) {
      assert_raises(NameError) {
        posts_controller.authorize!(post)
      }
    end

    def test_NoMethodError
      posts_controller.params[:action] = "update_all"
      assert_raises(Miau::NotDefinedError) {
        posts_controller.authorize!(post)
      }
    end
  end

  describe "#authorized?" do
    def test_return_true
      assert posts_controller.authorized?(post)
    end

    def test_return_false
      posts_controller.params[:action] = "destroy"
      refute posts_controller.authorized?(post)
    end
  end
end
