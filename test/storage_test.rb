require "test_helper"
require "yaml"

class ApplicationPolicy
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
    storage.reset
    storage.add_policy "application", "fail", "ok"

    str = storage.to_yaml
    assert_match(/:application/, str)
    assert_match(/:fail: :ok/, str)
  end

  def test_add_policy_methods
    storage.reset
    storage.add_policy "application", "fail", %i[fail ok]

    str = storage.to_yaml
    assert_match(/:application/, str)
    assert_match(/- :fail/, str)
    assert_match(/- :ok/, str)
  end

  def test_find_or_create
    storage.reset
    storage.find_or_create "application"

    assert ApplicationPolicy, storage.instances[:application]
  end

  def test_coverage_to_yaml
    str = storage.to_yaml

    assert str
    # puts str
  end
end
