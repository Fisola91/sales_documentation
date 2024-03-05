class SalesPerDayComponent < ViewComponent::Base
  def initialize(orders:)
    @orders = orders
  end

  def ground_total
    orders.sum { |order| order[:total]}
  end

  def date_format(date)
    date.strftime("%Y-%m-%d")
  end

  attr_reader :orders

  private

end

