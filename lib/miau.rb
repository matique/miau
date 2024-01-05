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
      helper_method :yyyy
    end
  end

def yyyy
ic :yyyyyyyyyyyyyyyyyyyy
ic self
ic miau_user
ic params
Miau::PolicyRun.instance.run(:dashboard, :controller, miau_user, nil)
ic :a9999999999999999999999999999999999999999999999999
end

  def authorize!(resource = nil, hsh = {})
    @_miau_authorization_performed = true
    return true if authorized?(resource, hsh)

    klass, action = klass_action
    msg = "class <#{klass} action <#{action}>"
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
    name = params[:controller].to_sym
    policy = PolicyStorage.instance.find_or_create_policy(name)
    raise NotDefinedError unless policy&.respond_to?(:controller)

    policy.send(:controller)
  end

  private

  def klass_action
    [params[:controller].to_sym, params[:action].to_sym]
  end
end
