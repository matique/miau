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

    controller = params[:controller].to_sym
    action = params[:action].to_sym
    PolicyRun.instance.raise_authorize(controller, action)
  end

  def authorized?(resource = nil, hsh = {})
    controller = params[:controller].to_sym
    action = params[:action].to_sym
    policy = PolicyStorage.instance.find_or_create_policy(controller)
    PolicyRun.instance.raise_undef(policy, action) unless policy

    policy.user = miau_user
    policy.resource = resource
    methods = PolicyRun.instance.find_methods(policy, controller, action)
    PolicyRun.instance.raise_undef(policy, action) unless methods

    PolicyRun.instance.runs(policy, methods)
  end

  def authorize_controller!
    controller = params[:controller].to_sym
    action = params[:action].to_sym
    policy = PolicyStorage.instance.find_or_create_policy(controller)
    policy.action = action

    @_miau_authorization_performed = true
    return true if PolicyRun.instance.runs(policy, :controller)

    PolicyRun.instance.raise_authorize policy, action
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

  private

  def klass_action
    [params[:controller].to_sym, params[:action].to_sym]
  end
end
