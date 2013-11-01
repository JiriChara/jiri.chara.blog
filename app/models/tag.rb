class Tag < ActiveRecord::Base
  has_and_belongs_to_many :articles

  validates_uniqueness_of :name

  class << self
    def with_names(names)
      names.map do |name|
        self.find_or_create_by(name: name)
      end
    end
  end

  def display_name
    name.titleize
  end
end
