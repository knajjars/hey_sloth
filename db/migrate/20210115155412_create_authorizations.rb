class CreateAuthorizations < ActiveRecord::Migration[6.1]
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.references :user, null: false, foreign_key: true
      t.string :token
      t.string :secret
      t.string :link

      t.timestamps
    end
  end
end
