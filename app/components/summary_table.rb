class SummaryTable < ViewComponent::Base
  def initialize(orders: [], show: true)
    @orders = orders
    @show = show
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
      date_time_str = orders.first.created_at.to_s
      date_time = DateTime.parse(date_time_str)
      date_str = date_time.strftime("%Y-%m-%d")
    end
  end

  attr_reader :orders, :show

  def show_class
    if show
      ""
    else
      "hidden"
    end
  end
end
