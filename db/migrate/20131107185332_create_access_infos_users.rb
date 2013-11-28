class CreateAccessInfosUsers < ActiveRecord::Migration
  def change
    create_table :access_infos_users do |t|
      t.belongs_to :user
      t.belongs_to :access_info
    end
  end
end
