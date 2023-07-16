class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.float :quantity
      t.float :unit_price
      t.float :total

      t.timestamps
    end
  end
end
