class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text       :text
      t.string     :ancestry
      t.references :user, index: true
      t.references :article, index: true

      t.timestamps
    end
    add_index :comments, :ancestry
  end
end
