class AddCountryAndCityToAccessInfos < ActiveRecord::Migration
  def change
    add_column :access_infos, :country, :string
    add_column :access_infos, :city, :string
  end
end
