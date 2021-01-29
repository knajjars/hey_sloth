class AddPublicTokenToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :public_token, :string, null: false
    add_index :users, :public_token, unique: true
  end
end
