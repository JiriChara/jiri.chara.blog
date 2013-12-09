class AccessInfo < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates_uniqueness_of :ip, scope: [:browser, :version, :platform]

  def geo_ip
    @geo_ip ||= GeoIP.new("#{Rails.root}/public/GeoLiteCity.dat")
  end

  def get_country
    if country.present?
      country
    else
      country = begin
        geo_ip.city(ip).country_name
      rescue
        "unknown"
      end
      self.update_column(:country, country).force_encoding("ISO-8859-1").encode("UTF-8")
      self.reload.country
    end
  end

  def get_city
    if city.present?
      city
    else
      city = begin
        geo_ip.city(ip).city_name.force_encoding("ISO-8859-1").encode("UTF-8")
      rescue
        "unknown"
      end
      self.update_column(:city, city)
      self.reload.city
    end
  end
end
