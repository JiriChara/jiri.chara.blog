class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :authentications

  scope :banned,     -> { where.not(banned_at: nil) }
  scope :not_banned, -> { where(banned_at: nil) }

  before_save { |user| user.email = user.email.downcase }
  before_save :create_remember_token

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
end
