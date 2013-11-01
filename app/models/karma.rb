class Karma < ActiveRecord::Base
  belongs_to :user
  belongs_to :karmable, polymorphic: true

  validates_numericality_of :value, in: (-1..1)
end
