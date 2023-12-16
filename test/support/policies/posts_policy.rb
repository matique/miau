# frozen_string_literal: true

class PostsPolicy < ApplicationPolicy
p 1111111111111111111
  miau %i[posts2 posts3], :posts1
  miau %i[index show], :bar
  miau %i[edit update], %i[posts1 bar]

  def posts1
    true
  end

  def destroy
    false
  end
end
