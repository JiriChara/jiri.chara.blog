class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image
      t.belongs_to :article

      t.timestamps
    end
  end
end
