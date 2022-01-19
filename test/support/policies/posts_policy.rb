# frozen_string_literal: true

class PostsPolicy < ApplicationPolicy
  miau %i[index show], :bar

  def update
    # user.admin? && resource.name == "Hugo"
    true
  end

  def bar
ic "bar"
    true
  end

  def destroy
    false
  end
end
