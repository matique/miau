class ApplicationController < ActionController::Base
  include Miau

  def miau_user
    "User"
  end
end
