class SummaryTable < ViewComponent::Base
  def initialize(orders: [])
    @orders = orders
  end

  def grand_total
    orders.sum { |order| order[:total] }
  end

  def grand_total_quantity
    orders.sum { |order| order[:quantity] }
  end

  def date_caption
    if orders.empty?
      nil
    else
      orders.first.date.strftime("%Y-%m-%d")
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
