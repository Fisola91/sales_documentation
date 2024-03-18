class DashboardController < ApplicationController
  include ApplicationHelper
  def index
    if params[:daily]
      @period = group_and_map_by_period(:day, 10)
    elsif params[:weekly]
      @period = group_and_map_by_period(:week)
    else
      @period = group_and_map_by_period(:month)
    end
    @last_five_sales = SalesPerDayComponent.new(orders: last_five_sales)
  end

  private

  def last_five_sales
    @top_sales ||= current_user_orders.group(:date)
                    .select("date, SUM(total) as total")
                    .order(date: :desc)
                    .limit(5)
  end

  def group_and_map_by_period(period, last_option = nil)
    current_user_orders.public_send("group_by_#{period}", :date, last: last_option)
      .sum(:total)
      .map do |date, total|
        if params[:monthly]
          [DatePresenter.formatted_monthly_year(date), total]
        else
          [DatePresenter.formatted_monthly_date(date), total]
        end
      end
  end
end