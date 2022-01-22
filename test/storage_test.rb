require "test_helper"

class ApplicationPolicy
  miau %i[appli2], :appli1
  miau %i[show edit], :bar2

  def appli1
    true
  end

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

  def test_find_policy
    check_find(PostsPolicy, :posts1, :posts, :posts1)
    check_find(PostsPolicy, :posts1, :posts, :posts2)
    check_find(PostsPolicy, :appli1, :posts, :appli1)
    check_find(ApplicationPolicy, :appli1, :posts, :appli2)
    check_find(ApplicationPolicy, :appli1, :unknown, :appli1)
    check_find(ApplicationPolicy, :appli1, :unknown, :appli21)

    check_nil(:posts, :unknown)
    check_nil(:unknown, :unknown)
  end


  def test_x
#    storage.reset
    str = storage.to_yaml
#ic str
puts str
#    storage.run :Posts, :update, user, nil
#    str = storage.to_yaml
  end

  private

  def check_find(expected_kind, expected_method, contr, action)
    inst, meth = storage.find_policy(contr, action)
    assert_kind_of(expected_kind, inst)
    assert_equal expected_method, meth
  end

  def check_nil(contr, action)
    res = storage.find_policy(contr, action)
    assert_nil res
  end
end
