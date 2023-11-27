class AddExternalIdToCredentials < ActiveRecord::Migration[7.0]
  def change
    add_column :credentials, :external_id, :string
  end
end
