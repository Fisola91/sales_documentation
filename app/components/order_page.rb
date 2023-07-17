class OrderPage < ViewComponent::Base
  def initialize(order: nil)
    @order = order
  end

  def summary
    return if @order.nil?
    @order
  end
end
