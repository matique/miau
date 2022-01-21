require "test_helper"

class ApplicationPolicy
  miau %i[show edit], :bar2

  def bar2
ic "bar2"
ic user, resource
    true
  end
end

describe Miau, "storage" do
  let(:storage) { Miau::PolicyStorage.instance }
  let(:user) { "User" }

#  def test_run
#    result = storage.run :Posts, :update, user, nil
#    assert result
#  end

  def xtest_x
    storage.reset
#ic str
puts str
    storage.run :Posts, :update, user, nil
    str = storage.to_yaml
  end

  def test_responder_posts_policy
ic storage.responder(:posts, :update)
#    assert_instance_of(PostsPolicy, storage.responder(:posts, :update))
  end

  def test_responder_posts_policy2
ic storage.responder(:posts, :show)
#    assert_instance_of(PostsPolicy, storage.responder(:posts, :show))
  end

  def test_responder_application
ic storage.responder(:application, :bar2)
#    assert_instance_of(ApplicationPolicy, storage.responder(:application, :bar2))
  end

  def test_responder_application2
ic storage.responder(:application, :edit)
ic storage.responder(:hugo, :edit)
#    assert_instance_of(ApplicationPolicy, storage.responder(:application, :edit))
  end

  def xtest_responder_application3
ic storage.responder(:posts, :edit)
    assert_instance_of(ApplicationPolicy, storage.responder(:posts, :edit))
  end
end
