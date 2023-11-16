class OrdersController < ApplicationController
  def index
    selected_date = date_from_see_details_params || Date.today

    orders = all_orders(selected_date)

    @form = order_form(orders)
    @summary = SummaryTable.new(orders: orders)
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

    @summary = SummaryTable.new(orders: all_orders(@order.created_at))
  end

  def update
    order = Order.find(params[:id])
    quantity = params.dig(:order, :quantity).to_f
    unit_price = params.dig(:order, :unit_price).to_f

    total = quantity * unit_price
    order_params = safe_params.merge(total: total)

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

  def date_from_see_details_params
    params["date"]
  end

  def order_form(orders)
    date_from_see_details_params ? OrderForm.new(date: date_str_format(orders)) : OrderForm.new
  end

  def date_str_format(orders)
    orders.first.date.strftime("%Y-%m-%d")
  end

  def all_orders(date)
    @all_orders ||= Order.created_on(date).order(date: :asc)
  end
end
