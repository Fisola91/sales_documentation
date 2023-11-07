class OrderManager
  def initialize(params)
    @params = params
  end

  def create_order
    quantity = safe_params.fetch(:quantity).to_f
    unit_price = safe_params.fetch(:unit_price).to_f

    created_date = params["date"]
    total = quantity * unit_price
    order_params = safe_params.merge(total: total, created_at: created_date)

    order = Order.new(order_params)
  end

  def update_order
    quantity = params.dig(:order, :quantity).to_f
    unit_price = params.dig(:order, :unit_price).to_f

    total = quantity * unit_price
    order_params = safe_params.merge(total: total)
  end


  private
  attr_reader :params

  def safe_params
    params.require(:order).permit(:name, :quantity, :unit_price)
  end
end