require "active_support/concern"
require "miau/version"
require "miau/error"
require "miau/storage"

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
    result = authorized?(resource, hsh)
    raise Miau::NotAuthorizedError unless result == true
  end

  def authorized?(resource = nil, hsh = {})
    klass = hsh[:policy_class]
    klass ||= params[:controller].camelize
    action = hsh[:policy_action]
    action ||= params[:action]
    PolicyStorage.instance.run(klass, action, miau_user, resource)
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
end
