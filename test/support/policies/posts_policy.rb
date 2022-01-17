class PostsPolicy < ApplicationPolicy
  miau %i[foopost], :update
  miau(%i[foopost2]) { user.admin? }

  def update
    # user.admin? && resource.name == "Hugo"
    true
  end

  def destroy
    false
  end
end
