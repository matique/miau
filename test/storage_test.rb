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

  def xtest_responder_posts_policy
    assert_instance_of(PostsPolicy, storage.responder(:posts, :update))
  end

  def xtest_responder_posts_policy2
    assert_instance_of(PostsPolicy, storage.responder(:posts, :show))
  end

  def xtest_responder_application
    assert_instance_of(ApplicationPolicy, storage.responder(:application, :bar2))
  end

  def test_responder_application2
p 7777777777777777777
ic storage.responder(:application, :edit)
p 77777777777777777771
ic storage.responder(:hugo, :edit)
p 77777777777777777772
#    assert_instance_of(ApplicationPolicy, storage.responder(:application, :edit))
  end

  def xtest_responder_application3
p 888888888888888888
ic storage.responder(:posts, :edit)
    assert_instance_of(ApplicationPolicy, storage.responder(:posts, :edit))
  end
end
