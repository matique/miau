require "test_helper"
require "yaml"

class ApplicationPolicy
  miau %i[appli2], :appli1

  def appli1
    true
  end

  def fail
    false
  end

  def ok
    true
  end
end

describe Miau, "storage" do
  let(:storage) { Miau::PolicyStorage.instance }
  let(:user) { "User" }

#  def test_run_unknown
#    assert_raises(Miau::NotDefinedError) {
#      storage.run :posts, :unknown, user, nil
#    }
#  end

#  def test_run_ok
#    result = storage.run :posts, :ok, user, nil
#    assert result
#  end
#
#  def test_run_fail
#    result = storage.run :posts, :fail, user, nil
#    refute result
#  end

#  def test_find_policy
#    check_find(PostsPolicy, :posts1, :posts, :posts1)
#    check_find(PostsPolicy, :posts1, :posts, :posts2)
#    check_find(PostsPolicy, :appli1, :posts, :appli1)
#    check_find(ApplicationPolicy, :appli1, :posts, :appli2)
#    check_find(ApplicationPolicy, :appli1, :unknown, :appli1)
#    check_find(ApplicationPolicy, :appli1, :unknown, :appli2)
#
#    check_nil(:posts, :unknown)
#    check_nil(:unknown, :unknown)
#  end

  def test_coverage_to_yaml
    str = storage.to_yaml
    # puts str

    assert str
  end

  private

#  def check_find(expected_kind, expected_method, contr, action)
#    msg = "check_find:"
#    msg += " #{expected_kind} #{expected_method}"
#    msg += " #{contr} #{action}"
#
#    inst, meth = storage.find_policy(contr, action)
#    assert_kind_of(expected_kind, inst, msg)
#    assert_equal(expected_method, meth, msg)
#  end

#  def check_nil(contr, action)
#    res = storage.find_policy(contr, action)
#    assert_nil res
#  end
end
