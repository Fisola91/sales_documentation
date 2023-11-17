class OrdersController < ApplicationController
  def index
    selected_date = date_from_see_details_params || Date.today

    orders = all_orders(selected_date)

    @form = order_form(orders)
    @summary = SummaryTable.new(orders: orders)
  end

  def create
    if order_manager.create_order
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "summary-table",
              SummaryTable.new(orders: all_orders(date_from_order_params))
            ),
            turbo_stream.replace(
              "form",
              OrderForm.new(date: date_from_order_params)
            )
          ]
        end
      end
    else
      raise NotImplementedError, "Order saving errors not handled"
    end
  end

  def edit
    @order = Order.find(params[:id])
    @form = OrderForm.new(order: @order)

    @summary = SummaryTable.new(orders: all_orders(@order.date))
  end

  def update
    order = Order.find(params[:id])

    if order_manager(order).update_order
      redirect_to orders_url
    else
      render :edit
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "summary-table",
          SummaryTable.new(orders: all_orders(order.created_at))
        )
      end
    end
  end

  private

  def safe_params
    params.require(:order).permit(:name, :quantity, :unit_price, :date)
  end

  def date_from_order_params
    safe_params.fetch(:date)
  end

  def name
    safe_params.fetch(:name)
  end

  def quantity
    safe_params.fetch(:quantity).to_f
  end

  def unit_price
    safe_params.fetch(:unit_price).to_f
  end

  def date_from_see_details_params
    params["date"]
  end

  def order_form(orders)
    if date_from_see_details_params
      OrderForm.new(date: date_str_format(orders))
    else
      OrderForm.new
    end
  end

  def date_str_format(orders)
    orders.first.date.strftime("%Y-%m-%d")
  end

  def order_manager(order = nil)
    @order_manager ||= construct_order_manager_for(order)
  end

  def construct_order_manager_for(order = nil)
    OrderManager.new(
      order: order,
      date: date_from_order_params,
      name: name,
      quantity: quantity,
      unit_price: unit_price,
    )
  end

  def all_orders(date)
    @all_orders ||= Order.created_on(date).order(date: :asc)
  end
end
