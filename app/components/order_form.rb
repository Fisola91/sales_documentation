class OrderForm < ViewComponent::Base
  def initialize(order: nil)
    @order = order
  end

  def form_method
    if order 
      :patch
    else
      :post
    end 
  end

  def form_url
    if order
      order_path(order.id)
    else
      orders_path
    end
  end

  def form_turbo
    if order
      false
    else
      true
    end
  end
  attr_reader :order
end
