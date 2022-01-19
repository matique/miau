# frozen_string_literal: true

require "active_support/concern"
require "miau/version"
require "miau/error"
require "miau/storage"
require "miau/storage"
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

    klass, action = klass_action(hsh)
    msg = "class <#{klass} action <#{action}>"
    raise Miau::NotAuthorizedError, msg
  end

  def authorized?(resource = nil, hsh = {})
    klass, action = klass_action(hsh)
    Miau::PolicyStorage.instance.run(klass, action, miau_user, resource)
  end

  def miau_user
    current_user
  end

  def skip_authorization
    @_miau_authorization_performed = true
  end

  def verify_authorized
    raise AuthorizationNotPerformedError unless miau_authorization_performed?
  end

  def miau_authorization_performed?
    !!@_miau_authorization_performed
  end

  private

  def klass_action(hsh)
    klass = hsh[:class]
    klass ||= params[:controller]
    action = hsh[:action]
    action ||= params[:action]
    [klass, action]
  end
end
