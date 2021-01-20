class CreateAuthorizations < ActiveRecord::Migration[6.1]
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.references :user, null: false, foreign_key: true
      t.text :token_ciphertext
      t.text :secret_ciphertext
      t.string :link

      t.timestamps
    end
  end
end
