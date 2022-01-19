# frozen_string_literal: true

class PostsPolicy < ApplicationPolicy
  miau %i[index show], :bar

  def update
ic "update"
    # user.admin? && resource.name == "Hugo"
    true
#    false
  end

  def bar
ic "bar"
    true
  end

  def destroy
    false
  end
end
