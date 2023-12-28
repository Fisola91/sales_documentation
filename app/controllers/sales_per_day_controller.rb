class SalesPerDayController < ApplicationController

  def index
    if params[:date_range]
      start_date, end_date = params[:date_range].split(" - ")

      selected_orders = Order.where(date: start_date..end_date).order(date: :asc)

      @all_sales = SalesPerDayComponent.new(orders: selected_orders)
    else
      @all_sales = SalesPerDayComponent.new(orders: all_orders)
    end

  end

  private

  def all_orders
    @all_orders ||= Order.order(date: :asc)
  end
end
