class DropCredentials < ActiveRecord::Migration[7.0]
  def change
    drop_table :credentials
  end
end
