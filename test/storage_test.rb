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
  let(:user) { "User" }

  def test_add
    storage.reset
    storage.add ApplicationPolicy, "fail", "ok"

    str = storage.to_yaml
    assert_match(/:application/, str)
    assert_match(/:fail: :ok/, str)
  end

  def test_add2
    storage.reset
    storage.add ApplicationPolicy, "fail", %i[fail ok]

    str = storage.to_yaml
puts str
    assert_match(/:application/, str)
    assert_match(/- :fail/, str)
    assert_match(/- :ok/, str)
  end

  def test_coverage_to_yaml
    str = storage.to_yaml

    assert str
    # puts str
  end
end
