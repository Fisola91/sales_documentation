class AddIndexToOrders < ActiveRecord::Migration[7.0]
  def change
    add_index(:orders, :date)
  end
end
