class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :authentications
  has_and_belongs_to_many :access_infos

  scope :banned,     -> { where.not(banned_at: nil) }
  scope :not_banned, -> { where(banned_at: nil) }

  before_save { |user| user.email = user.email.downcase }
  before_save :create_remember_token

  before_create :set_slug

  before_create :set_auth_token

  def admin?
    role == "admin"
  end

  def moderator?
    role == "moderator"
  end

  def ban!
    update(banned_at: Time.now)
  end

  def unban!
    update(banned_at: nil)
  end

  def banned?
    banned_at.present?
  end

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64 unless remember_token
  end

  def name_or_email
    name || email
  end

  def to_param
    slug
  end

  def avatar(opts={})
    opts[:size] ||= 48

    if avatar_url.present?
      avatar_url
    else
      gravatar_id = Digest::MD5.hexdigest(email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{opts[:size]}&d=retro"
    end
  rescue
    guest_avatar_url
  end

  def guest_avatar_url(opts={})
    "images/default_avatar.jpg"
  end

  class << self
    def from_omniauth(omniauth)
      auth = Authentication.find_or_create_by(
        provider:  omniauth['provider'],
        uid:       omniauth['uid']
      )

      user = self.find_or_create_by(
        email: omniauth['info']['email'],
        name:  omniauth['info']['name']
      )

      auth.user = user; auth.save

      user
    end
  end

private
  def set_slug
    if self.name.present?
      self.slug = name.parameterize
    else
      self.slug = SecureRandom.hex
    end
  end

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    loop do
      token = SecureRandom.hex
      break token unless self.class.exists?(auth_token: token)
    end
  end
end
