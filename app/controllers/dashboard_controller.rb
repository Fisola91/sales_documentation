class DashboardController < ApplicationController
  def index
    if params[:monthly]
      @period = monthly
    elsif params[:weekly]
      @period = weekly
    else
      @period = daily
    end

    @top_five_sales = SalesPerDayComponent.new(orders: top_five_sales)
  end

  private
  def top_five_sales
    @top_sales ||= Order.group(:date)
                        .select("date, SUM(total) as total")
                        .order(date: :desc)
                        .limit(5)
  end

  def monthly
    Order.group_by_month(:date).sum(:total)
  end

  def weekly
    Order.group_by_week(:date).sum(:total)
  end

  def daily
    Order.group_by_day(:date, last: 10).sum(:total)
  end
end