class OrdersPolicy < ApplicationPolicy
  def controller
    puts :controller
    true
  end

  def new
    puts :new
    true
  end

  def destroy
    puts :destroy
    true
  end
end
