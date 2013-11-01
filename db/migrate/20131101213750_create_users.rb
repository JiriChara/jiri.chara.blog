class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :remember_token
      t.string :role
      t.datetime :banned_at
      t.string :avatar_url

      t.timestamps
    end
  end
end
