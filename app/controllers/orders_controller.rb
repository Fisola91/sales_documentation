class OrdersController < ApplicationController
  def index
    @form = OrderForm.new
    if params["date"]
      date = Date.parse(params["date"])
      orders = Order.created_on(date)
      @summary = SummaryTable.new(
        orders: orders,
        show: all_orders.any?
      )
    else
      @summary = SummaryTable.new(
        orders: all_orders,
        show: all_orders.any?
      )
    end
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
              SummaryTable.new(orders: all_orders)
            ),
            turbo_stream.replace(
              "form",
              OrderForm.new
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

    @summary = SummaryTable.new(
      orders: all_orders,
      show: all_orders.any?
    )
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
          SummaryTable.new(orders: all_orders)
        )
      end
    end
  end

  private

  def safe_params
    params.require(:order).permit(:name, :quantity, :unit_price)
  end

  def all_orders
    @all_orders ||= Order.order(created_at: :asc)
  end

  def date_format
  end
end
