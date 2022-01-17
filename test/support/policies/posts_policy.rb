class PostsPolicy < ApplicationPolicy
  miau %i[index], :update

  def update
    # user.admin? && resource.name == "Hugo"
    true
  end

  def destroy
    false
  end
end
