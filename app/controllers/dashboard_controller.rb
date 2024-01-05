class DashboardController < ApplicationController
  def index
    @top_five_sales = SalesPerDayComponent.new(orders: top_five_sales)
  end

  private
  def top_five_sales
    @top_sales ||= Order.group(:date)
                        .select("date, SUM(total) as total")
                        .order(date: :desc)
                        .limit(5)
  end
end