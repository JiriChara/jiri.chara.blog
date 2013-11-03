class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string     :title
      t.string     :slug
      t.text       :content
      t.datetime   :published_at
      t.string     :type
      t.references :user, index: true

      t.timestamps
    end
  end
end
