class SalesPerDayController < ApplicationController

  def index
    date_range = params[:date_range]
    if date_range
      start_date, end_date = date_range.split(" - ")

      @all_sales = SalesPerDayComponent.new(orders: selected_orders(start_date, end_date))
    else
      @all_sales = SalesPerDayComponent.new(orders: all_orders)
    end

  end

  private

  def selected_orders(start_date, end_date)
    selected_orders ||= current_user_orders.where(date: start_date..end_date)
                           .group(:date)
                           .select("date, SUM(total) as total")
                           .order(date: :asc)
  end

  def all_orders
    @all_orders ||= current_user_orders.group(:date)
                         .select("date, SUM(total) as total")
                         .order(date: :desc)
  end
end

