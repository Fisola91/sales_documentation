class OrderForm < ViewComponent::Base
  def initialize(order: nil)
    @order = order
  end

  def form_method
    order ? :patch : :post
  end

  def form_url
    order ? order_path(order) : orders_path
  end

  def form_turbo
    order ? false : true
  end

  def submit
    order ? "Update" : "Save"
  end

  attr_reader :order
end
