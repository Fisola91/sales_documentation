class OrderForm < ViewComponent::Base
  def initialize(order: nil, date: nil)
    @order = order
    @date = date
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

  def created_date
    date.nil? ? Date.today.strftime('%Y-%m-%d') : date
  end

  attr_reader :order, :date
end
