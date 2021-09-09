class PostsPolicy < ApplicationPolicy
  def update
    # user.admin? && resource.name == "Hugo"
    true
  end

  def destroy
    false
  end
end
