require "test_helper"

describe Miau, "storage" do
  let(:storage) { Miau::PolicyStorage.instance }
  let(:user) { "User" }

  def test_run
    result = storage.run :Posts, :update, user, nil
    assert result
  end

  def test_x
    storage.reset
    storage.run :Posts, :update, user, nil
    str = storage.to_yaml
#ic str
puts str
  end
end
