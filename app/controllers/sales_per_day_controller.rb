class SalesPerDayController < ApplicationController

  def index
    @all_sales = SalesPerDayComponent.new(orders: all_orders)
  end

  private

  def all_orders
    @all_orders ||= Order.order(date: :asc)
  end
end
