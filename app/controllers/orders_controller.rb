class OrdersController < ApplicationController
  def index
    @form = OrderForm.new

    @summary = SummaryTable.new(
      orders: all_orders,
      show: all_orders.any?
    )
  end

  def create
    quantity = safe_params.fetch(:quantity).to_f
    unit_price = safe_params.fetch(:unit_price).to_f

    total = quantity * unit_price
    order_params = safe_params.merge(total: total)

    order = Order.new(order_params)

    if order.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "summary-table",
            SummaryTable.new(orders: all_orders)
          )
        end
      end
    else
      raise NotImplementedError, "Order saving errors not handled"
    end
  end

  private

  def safe_params
    params.require(:order).permit(:name, :quantity, :unit_price)
  end

  def all_orders
    @all_orders ||= Order.all
  end
end
