require 'karmable'

class Article < ActiveRecord::Base
  include Karmable

  DEFAULT_PER_PAGE       = 3
  DEFAULT_PER_PAGE_TABLE = 30

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :images,   dependent: :destroy

  has_and_belongs_to_many :tags

  before_create :set_slug

  validates_presence_of :title, :content
  validates_uniqueness_of :slug

  scope :published,     -> { where.not(published_at: nil) }
  scope :unpublished,   -> { where(published_at: nil) }
  scope :only_articles, -> { where(type: "Article") }

  attr_accessor :tag_list

  def publish!
    update(published_at: Time.now.utc)
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

  def to_param
    slug
  end

  def author
    user
  end

private
  def set_slug
    self.slug = title.parameterize
  end
end
