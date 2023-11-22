class OrderFormBase < ViewComponent::Base
  def initialize(order:)
    @order = order
  end

  def created_date
    order.date.strftime('%Y-%m-%d')
  end

  attr_reader :order

  def form_method
    raise NotImplementedError
  end

  def form_url
    raise NotImplementedError
  end

  def form_turbo
    raise NotImplementedError
  end

  def submit
    raise NotImplementedError
  end
end
