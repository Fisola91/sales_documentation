class SalesPerDayController < ApplicationController

  def index
    if params[:date_range]
      start_date, end_date = params[:date_range].split(" - ")

      selected_orders = Order.where(date: start_date..end_date).group(:date).select("date, SUM(total) as total").order(date: :asc)
      # Order.where(date: start_date..end_date).group(:date).order(date: :asc).select("date").sum(:total)

      @all_sales = SalesPerDayComponent.new(orders: selected_orders)
    else
      @all_sales = SalesPerDayComponent.new(orders: all_orders)
    end

  end

  private

  def all_orders
    @all_orders ||= Order.group(:date)
                         .select("date, SUM(total) as total")
                         .order(date: :desc)
  end
end

