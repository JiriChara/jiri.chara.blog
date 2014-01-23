class Tag < ActiveRecord::Base
  has_and_belongs_to_many :articles

  before_create :set_slug

  validates_uniqueness_of :name

  class << self
    def with_names(names)
      names.map do |name|
        self.find_or_create_by(name: name)
      end
    end
  end

  def display_name
    name
  end

  def to_param
    slug
  end

private
  def set_slug
    self.slug = name.parameterize
  end
end
