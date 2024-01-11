class OrdersPolicy < ApplicationPolicy
  def controller
#p 1111111111111111111
    true
  end

  def xnew
#p 55555555555555
    true
  end

  def destroy
#p 2222222222222
    true
  end
end
