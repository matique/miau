require "test_helper"
require "miau/application_policy"

class ApplicationPolicy
  miau %i[action buh bar], :foo

  def foo
ic "foo"
ic user, resource
    true
  end
end

#describe ApplicationPolicy, "without Controller" do
describe ApplicationPolicy do
  let(:user) { "User" }
  let(:post) { Post.new(user, 1) }
  let(:params) { {action: "update", controller: "posts"} }
  let(:posts_controller) { PostsController.new(user, params) }
  let(:storage) { Miau::PolicyStorage.instance }

  describe "#authorize!" do
#authorize! article, policy: :Comments, action: :extract
    def test_x
      str = storage.to_yaml
#ic str
puts str
      posts_controller.authorize!(post, policy: nil, action: :action)
    end
  end
end
