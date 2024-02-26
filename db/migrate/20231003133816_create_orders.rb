class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :name, null: false
      t.float :quantity, null: false
      t.float :unit_price, null: false
      t.float :total, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
