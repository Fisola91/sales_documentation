# frozen_string_literal: true

class SalesPerDayComponent < ViewComponent::Base
  def initialize(orders:)
    @orders = orders
  end

  def group_by_date
    orders.group_by do |order|
      date_time_str = order[:created_at].to_s
      date_time = DateTime.parse(date_time_str)
      date_str = date_time.strftime("%Y-%m-%d")
      date = date_str 
    end
  end
  attr_reader :orders
end
