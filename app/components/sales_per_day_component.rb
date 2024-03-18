class SalesPerDayComponent < ViewComponent::Base
  include ApplicationHelper
  def initialize(orders:)
    @orders = orders
  end

  def ground_total
    orders.sum { |order| order[:total]}
  end

  attr_reader :orders

  private

end

