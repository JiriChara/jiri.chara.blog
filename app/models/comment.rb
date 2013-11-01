class Comment < ActiveRecord::Base
  include Karmable

  belongs_to :user
  belongs_to :article

  validates_presence_of :text, :article_id, :user_id
end
