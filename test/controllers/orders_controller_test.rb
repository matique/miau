require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = Order.create!(name: "Name", qty: 123)
  end

  def test_new
    out, err = capture_io do
      get new_order_url
    end

    assert_response :success
    assert_equal "controller\nnew\n", out
  end

  def test_create
    out, err = capture_io do
      assert_difference("Order.count") do
        post orders_url, params: {order: {name: @order.name, qty: 234}}
      end
    end

    assert_redirected_to order_url(Order.last)
    assert_equal "controller\n", out
  end

  def test_update
    out, err = capture_io do
      patch order_url(@order), params: {order: {name: @order.name}}
    end

    assert_redirected_to order_url(@order)
    assert_equal "controller\n", out
  end

  def test_destroy
    out, err = capture_io do
      assert_difference("Order.count", -1) do
        delete order_url(@order)
      end
    end

    assert_redirected_to orders_url
    assert_equal "controller\ndestroy\n", out
  end
end
