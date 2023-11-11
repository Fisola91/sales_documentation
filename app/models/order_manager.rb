class OrderManager
  def initialize(safe_params, quantity, unit_price, date: nil)
    @safe_params = safe_params
    @quantity = quantity
    @unit_price = unit_price
    @date = date
  end

  def create_order
    created_date = date
    order_params = safe_params.merge(total: total, created_at: created_date)

    Order.new(order_params)
  end

  def update_order
    safe_params.merge(total: total)
  end


  private

  attr_reader :safe_params, :quantity, :unit_price, :date

  def total
    quantity * unit_price
  end
end