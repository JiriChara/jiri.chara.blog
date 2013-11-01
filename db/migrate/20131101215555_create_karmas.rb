class CreateKarmas < ActiveRecord::Migration
  def change
    create_table :karmas do |t|
      t.references :user, index: true
      t.integer :value, default: 0
      t.references :karmable, polymorphic: true
      t.timestamps
    end
  end
end
