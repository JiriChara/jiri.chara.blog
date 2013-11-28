class Image < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::NumberHelper

  belongs_to :article

  mount_uploader :image, ImageUploader

  def to_jq_upload
    {
      name:          read_attribute(:image),
      size:          number_to_human_size(image.size),
      url:           image.url,
      thumbnail_url: image.thumb.url,
      delete_url:    image_path(id: id),
      delete_type:   "DELETE"
    }
  end
end
