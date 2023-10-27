class SummaryTable < ViewComponent::Base
  def initialize(orders: [])
    @orders = orders
  end

  def grand_total
    total_sum = orders.reduce(0) do |sum, hash|
      sum + hash[:total]
    end
    total_sum
  end

  def grand_total_quantity
    total_quantity = orders.reduce(0) do |sum, hash|
      sum + hash[:quantity]
    end
    total_quantity
  end

  def date_caption
    if orders.empty?
      nil
    else
      orders.first.created_at.strftime("%Y-%m-%d")
    end
  end

  attr_reader :orders

  def show_class
    if orders.any?
      ""
    else
      "hidden"
    end
  end
end
