require "test_helper"

class ApplicationPolicy
  miau :nein, :ja

  def ja
    true
  end
end

class SiiPolicy < ApplicationPolicy
  miau :no, :si

  def si
    true
  end
end

describe Miau, "run2" do
  let(:storage) { Miau::PolicyStorage.instance }
  let(:miau_run) { Miau::PolicyRun.instance }
  let(:user) { "User" }

  def test_run_si
    miau_run.run :sii, :si, user, nil
  end

  def test_run_no
    miau_run.run :sii, :no, user, nil
  end

  def test_run_unknown
    assert_raises(Miau::NotDefinedError) {
      miau_run.run :sii, :unknown, user, nil
    }
  end

  def test_run_ja
    miau_run.run :sii, :ja, user, nil
  end

  def test_run_nein
    miau_run.run :sii, :nein, user, nil
  end
end
