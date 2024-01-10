# frozen_string_literal: true

require "active_support/concern"
require "miau/version"
require "miau/error"
require "miau/storage"
require "miau/run"
require "miau/application_policy"

module Miau
  extend ActiveSupport::Concern

  included do
    if respond_to?(:helper_method)
      helper_method :authorized?
      helper_method :miau_user
    end
  end

  def authorize!(resource = nil, hsh = {})
    @_miau_authorization_performed = true
    return true if authorized?(resource, hsh)

    klass, action = klass_action
    msg = "class <#{klass}> action <#{action}>"
    raise NotAuthorizedError, msg
  end

  def authorized?(resource = nil, hsh = {})
    klass, action = klass_action
    PolicyRun.instance.run(klass, action, miau_user, resource)
  end

  def miau_user
    current_user
  end

  def verify_authorized
    raise AuthorizationNotPerformedError unless miau_authorization_performed?
  end

  def miau_authorization_performed?
    !!@_miau_authorization_performed
  end

  def authorize_controller!
    klass, action = klass_action
    policy = PolicyStorage.instance.find_or_create_policy(klass)
    policy.action = action
    return true if PolicyRun.instance.runs(policy, :controller)

    PolicyRun.instance.raise_authorize policy, action
  end

  private

  def klass_action
    [params[:controller].to_sym, params[:action].to_sym]
  end
end
