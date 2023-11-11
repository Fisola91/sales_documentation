class OrdersController < ApplicationController
  def index
    today_date = Date.today
    @form = OrderForm.new
    if date_from_params
      orders = all_orders(date_from_params)
      @form = OrderForm.new(date: orders.first.created_at)
      @summary = SummaryTable.new(orders: orders)
    else
      @summary = SummaryTable.new(orders: all_orders(today_date))
    end
  end

  def create
    order = OrderManager.new(
      safe_params,
      quantity,
      unit_price,
      date: date_from_params
    ).create_order


    if order.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "summary-table",
              SummaryTable.new(orders: all_orders(order.created_at))
            ),
            turbo_stream.replace(
              "form",
              OrderForm.new(date: order.created_at)
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

    @summary = SummaryTable.new(orders: all_orders(date_order_created(@order)))
  end

  def update
    order = Order.find(params[:id])
    order_params = OrderManager.new(
      safe_params,
      quantity,
      unit_price
    ).update_order

    if order.update(order_params)
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
          SummaryTable.new(orders: all_orders(date_order_created(order)))
        )
      end
    end
  end

  private

  def safe_params
    params.require(:order).permit(:name, :quantity, :unit_price)
  end

  def quantity
    safe_params.fetch(:quantity).to_f
  end

  def unit_price
    safe_params.fetch(:unit_price).to_f
  end

  def date_from_params
    params["date"]
  end

  def date_order_created(order)
    order.created_at
  end

  def all_orders(date)
    @all_orders ||= Order.created_on(date).order(created_at: :asc)
  end

  def updated_all_order
    @all_orders ||= Order.order(updated_at: :desc)
  end
end
