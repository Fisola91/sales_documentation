class OrdersController < ApplicationController
  def index
    if no_date_set?
      return redirect_to orders_path(date: Date.today)
    end

    orders = all_orders(selected_date)

    @form = NewOrderForm.new(order: Order.new(date: selected_date))
    @summary = SummaryTable.new(orders: orders)
  end

  def create
    if order_manager.create_order(current_user)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "summary-table",
              SummaryTable.new(orders: all_orders(date_from_params))
            ),
            turbo_stream.replace(
              "form",
              NewOrderForm.new(order: Order.new(date: date_from_params))
            )
          ]
        end
      end
    else
      raise NotImplementedError, "Order saving errors not handled"
    end
  end

  def edit
    order = Order.find(params[:id])

    @form = EditOrderForm.new(order: order)
    @summary = SummaryTable.new(orders: all_orders(order.date))

  rescue ActiveRecord::RecordNotFound => error
    redirect_to orders_url, flash: {alert: error.message }
  end

  def update
    order = Order.find(params[:id])

    if order_manager(order).update_order

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "summary-table",
              SummaryTable.new(orders: all_orders(date_from_params))
            ),
            turbo_stream.replace(
              "form",
              NewOrderForm.new(order: Order.new(date: date_from_params))
            ),
            turbo_stream.before(
              "form",
              partial: "orders/updated_message"
            )
          ]
        end
      end
    else
      render :edit
    end
  end

  def destroy
    order = Order.find(params[:id])
    if order.destroy!
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "summary-table",
            SummaryTable.new(orders: all_orders(order.date))
          )
        end
      end
    end
  rescue ActiveRecord::RecordNotFound => error
    redirect_to orders_url, flash: {alert: error.message }
  end

  private

  def no_date_set?
    selected_date.nil?
  end

  def safe_params
    params.require(:order).permit(:name, :quantity, :unit_price, :date)
  end

  def date_from_params
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

  def selected_date
    params["date"]
  end

  def order_manager(order = "")
    @order_manager ||= OrderManager.new(
      order: order,
      date: date_from_params,
      name: name,
      quantity: quantity,
      unit_price: unit_price
    )
  end

  def all_orders(date)
    @all_orders ||= current_user_orders.created_on(date).order(created_at: :desc)
  end
end
