require "test_helper"
require "yaml"

class MyPolicy < ApplicationPolicy
  miau %i[appli2], :appli1
  miau %i[appli3], %i[fail ok]

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

  def test_add_policy_method
    storage.add_policy "my", "fail", "ok"

    str = storage.to_yaml
    assert_match(/:my/, str)
    assert_match(/:fail: :ok/, str)
  end

  def test_add_policy_methods
    storage.add_policy "my", "failx", %i[fail ok]

    str = storage.to_yaml
    assert_match(/:my/, str)
    assert_match(/- :fail/, str)
    assert_match(/- :ok/, str)
  end

  def test_find_or_create_policy
    storage.find_or_create_policy "application"

    assert ApplicationPolicy, storage.instances[:application]
  end

  def test_overwrite
    storage.add_policy "my", "first", "ok"
    assert_raises(Miau::OverwriteError) {
      storage.add_policy "my", "first", "ok"
    }
  end

  def test_coverage_to_yaml
    str = storage.to_yaml

    assert str
    # puts str
  end
end
