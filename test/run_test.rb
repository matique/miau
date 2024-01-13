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

  def run
    puts :run # use by capture_io
    true
  end
end

describe Miau, "run2" do
  let(:storage) { Miau::PolicyStorage.instance }
  let(:miau_run) { Miau::PolicyRun.instance }
  let(:policy) { SiiPolicy.new }
  let(:user) { "User" }

  def test_find_methods_si
    assert_equal :si, miau_run.find_methods(policy, :sii, :si)
  end

  def test_find_methods_no
    assert_equal :si, miau_run.find_methods(policy, :sii, :no)
  end

  def test_find_methods_unknown
    refute miau_run.find_methods(policy, :sii, :unknown)
  end

  def test_find_methods_ja
    assert_equal :ja, miau_run.find_methods(policy, :sii, :ja)
  end

  def test_find_methods_nein
    assert_equal :ja, miau_run.find_methods(policy, :sii, :ja)
  end

  def test_runs
    out, _err = capture_io do
      miau_run.runs(policy, :run)
    end

    assert_equal "run\n", out
  end

  def test_raise_undef
    assert_raises(Miau::NotDefinedError) {
      miau_run.raise_undef(:sii, :ja)
    }
  end

  def test_raise_authorize
    assert_raises(Miau::NotAuthorizedError) {
      miau_run.raise_authorize(:sii, :ja)
    }
  end
end
