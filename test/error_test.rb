require "test_helper"

describe Miau::Error do
  def test_presence_of_errors
    assert_raises(Miau::Error) {
      raise Miau::Error
    }
    assert_raises(Miau::NotAuthorizedError) {
      raise Miau::NotAuthorizedError
    }
    assert_raises(Miau::NotDefinedError) {
      raise Miau::NotDefinedError
    }
    assert_raises(Miau::AuthorizationNotPerformedError) {
      raise Miau::AuthorizationNotPerformedError
    }
  end

  def test_raise_error_with_options
    assert_raises(Miau::NotAuthorizedError) {
      raise Miau::NotAuthorizedError.new("message")
    }
  end

  def test_error_initialization
    msg = "must be logged in"
    error = Miau::NotAuthorizedError.new(msg)
    assert_equal msg, error.message
  end
end
