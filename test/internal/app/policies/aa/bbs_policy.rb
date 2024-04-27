module Aa
  class BbsPolicy < ApplicationPolicy
    def controller
      true
    end

    def show
      true
    end
  end
end
