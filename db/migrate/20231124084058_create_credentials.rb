class CreateCredentials < ActiveRecord::Migration[7.0]
  def change
    create_table :credentials do |t|
      t.string :public_key
      t.string :nickname
      t.bigint :sign_count, default: 0, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
