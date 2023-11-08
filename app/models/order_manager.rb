class OrderManager
  def initialize(params)
    @params = params
  end

  def create_order
    created_date = params["date"]
    order_params = safe_params.merge(total: total, created_at: created_date)

    order = Order.new(order_params)
  end

  def update_order
    order_params = safe_params.merge(total: total)
  end


  private

  attr_reader :params

  def safe_params
    params.require(:order).permit(:name, :quantity, :unit_price)
  end

  def quantity
    if safe_params
      safe_params.fetch(:quantity).to_f
    else
      params.dig(:order, :quantity).to_f
    end
  end

  def unit_price
    if safe_params
      safe_params.fetch(:unit_price).to_f
    else
      params.dig(:order, :unit_price).to_f
    end
  end

  def total
    quantity * unit_price
  end
end