# frozen_string_literal: true

class SalesPerDayComponent < ViewComponent::Base
  def initialize(orders:)
    @orders = orders
  end

  def grouped_by_date
    orders.group_by do |order|
      date_format(order)
    end
  end

  def sales_per_day_total(day_orders)
    day_orders.sum { |order| order[:total] }
  end

  attr_reader :orders

  private

  def date_format(order)
    order.created_at.strftime("%Y-%m-%d")
  end
end
