class AddDateToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :date, :datetime
  end
end
