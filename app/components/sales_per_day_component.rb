class SalesPerDayComponent < ViewComponent::Base
  def initialize(orders:)
    @orders = orders
  end

  def ground_total
    orders.sum { |order| order[:total]}
  end

  attr_reader :orders
end

