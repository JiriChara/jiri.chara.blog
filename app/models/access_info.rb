class AccessInfo < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates_uniqueness_of :ip, scope: [:browser, :version, :platform]
end
