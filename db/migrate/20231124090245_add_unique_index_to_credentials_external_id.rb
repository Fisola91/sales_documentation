class AddUniqueIndexToCredentialsExternalId < ActiveRecord::Migration[7.0]
  def change
    add_index :credentials, :external_id, unique: true
  end
end
