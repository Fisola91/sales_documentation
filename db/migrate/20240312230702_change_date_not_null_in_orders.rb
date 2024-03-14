class ChangeDateNotNullInOrders < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :date, :datetime, null: false
  end
end
