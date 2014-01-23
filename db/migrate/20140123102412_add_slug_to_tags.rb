class AddSlugToTags < ActiveRecord::Migration
  def change
    add_column :tags, :slug, :string

    Tag.all.each do |tag|
      tag.send(:set_slug)
      tag.save
    end
  end
end
