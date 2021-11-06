require "test_helper"

describe Miau, "storage" do
  let(:storage) { Miau::PolicyStorage.instance }
  let(:user) { "User" }

  def test_run
    result = storage.run :Posts, :update, user, nil
    assert result
  end
end
