class CreateAccessInfos < ActiveRecord::Migration
  def change
    create_table :access_infos do |t|
      t.string :ip
      t.string :browser
      t.string :version
      t.string :platform

      t.timestamps
    end
  end
end
