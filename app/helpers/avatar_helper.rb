module AvatarHelper
  def avatar_url(user, opts={})
    opts[:size] ||= 48

    if user.avatar_url.present?
      user.avatar_url
    else
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{opts[:size]}&d=retro"
    end
  rescue
    guest_avatar_url
  end

  def guest_avatar_url(opts={})
    "default_avatar.jpg"
  end
end
