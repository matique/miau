class PostsController
  include Miau

  attr_accessor :current_user, :params

  def initialize(current_user, params = {})
    @current_user = current_user
    @params = params
  end
end
