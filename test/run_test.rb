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

describe Miau, "run" do
  let(:storage) { Miau::PolicyStorage.instance }
  let(:miau_run) { Miau::PolicyRun.instance }
  let(:user) { "User" }

  def setup
#    storage.reset
  end


#  def test_run_unknown
#    assert_raises(Miau::NotDefinedError) {
#      miau_run.run :posts, :unknown, user, nil
#    }
#  end

#  def test_run_ok
#    result = miau_run.run :posts, :posts1, user, nil
#    assert result
#  end
#
#  def test_run_fail
#    result = miau_run.run :posts, :destroy, user, nil
#    refute result
#  end

  def test_find_policy
    check_find(PostsPolicy, :si, :posts, :si)
    check_find(PostsPolicy, :si, :posts, :asi)
    check_find(PostsPolicy, :appli1, :posts, :appli1)
    check_find(ApplicationPolicy, :appli1, :posts, :appli2)
#    check_find(:application, :appli1, :unknown, :appli1)
#    check_find(:application, :appli1, :unknown, :appli2)

    check_nil(:posts, :unknown)
    check_nil(:unknown, :unknown)
  end

#  def test_coverage_to_yaml
#    str = miau_run.to_yaml
#    # puts str
#
#    assert str
#  end

  private

  def check_find(expected_klass, expected_method, contr, action)
ic 777, expected_klass, expected_method, contr, action
    msg = "check_find:"
    msg += " #{expected_klass} #{expected_method}"
    msg += " #{contr} #{action}"

    klass, meth = miau_run.find_policy(contr, action)
ic 554, klass, meth
ic 555, expected_klass, meth
#    assert_equal(expected_klass, klass.class, msg)
    assert_equal(expected_klass, klass, msg)
    assert_equal(expected_method, meth, msg)
  end

  def check_nil(contr, action)
#    res = storage.find_policy(contr, action)
    res = miau_run.find_policy(contr, action)
    assert_nil res
  end
end
