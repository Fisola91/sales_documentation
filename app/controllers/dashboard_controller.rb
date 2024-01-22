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
    @top_sales ||= current_user_orders.group(:date)
                        .select("date, SUM(total) as total")
                        .order(date: :desc)
                        .limit(5)
  end

  def monthly
    current_user_orders.group_by_month(:date).sum(:total)
    .map do |date, total|
      [parsed_date(date), total]
    end
  end

  def weekly
    current_user_orders.group_by_week(:date).sum(:total)
    .map do |date, total|
      [parsed_date(date), total]
    end
  end

  def daily
    current_user_orders.group_by_day(:date, last: 10).sum(:total)
    .map do |date, total|
      [parsed_date(date), total]
    end
  end

  def parsed_date(date)
    params[:daily] ? Date.parse(date.to_s).strftime("%b %d") : Date.parse(date.to_s).strftime("%b %Y")
  end
end