class OrderPage < ViewComponent::Base
  def initialize(order: nil)
    @order = order
  end

  def summary
    return if @order.nil?
    @order.name
    @order.quantity
    @order.unit_price
    @order.total
  end
end
