# frozen_string_literal: true

class PostsPolicy < ApplicationPolicy
  miau %i[posts2 posts3], :posts1
  miau %i[index show], :bar

  def posts1
    true
  end

  def destroy
    false
  end
end
