# frozen_string_literal: true

class PostsPolicy < ApplicationPolicy
  miau %i[asi bsi], :si
  miau %i[sino], %i[si no]

  def controller
    false
  end

  def si
    true
  end

  def no
    false
  end
end
