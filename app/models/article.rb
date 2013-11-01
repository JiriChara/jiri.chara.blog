require 'karmable'

class Article < ActiveRecord::Base
  include Karmable

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :images,   dependent: :destroy

  has_and_belongs_to_many :tags

  validates_presence_of :title, :content

  scope :published,     -> { where.not(published_at: nil) }
  scope :unpublished,   -> { where(published_at: nil) }
  scope :only_articles, -> { where(type: "Article") }

  attr_accessor :tag_list

  def publish!
    update(published_at: Time.now)
  end

  def unpublish!
    update(published_at: nil)
  end

  def published?
    published_at.present?
  end

  def tag_list=(names)
    self.tags = Tag.with_names(names.split(','))
  end

  def tag_list
    tags.map(&:name).join(',')
  end
end
