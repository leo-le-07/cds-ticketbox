class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :uid
      t.string :provider

      t.timestamps null: false
    end
  end
end
