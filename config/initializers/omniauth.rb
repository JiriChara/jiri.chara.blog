require 'openid/store/memcache'
require "openid/fetchers"

OpenID.fetcher.ca_file = "/etc/ssl/certs/ca-certificates.crt"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, CONFIG[:omniauth][:facebook][:key],
    CONFIG[:omniauth][:facebook][:secret]

  provider :github, CONFIG[:omniauth][:github][:key],
    CONFIG[:omniauth][:github][:secret], scope: 'user'

  provider :open_id, :name => 'google',
    :identifier => 'https://www.google.com/accounts/o8/id',
    :store => OpenID::Store::Memcache.new(Dalli::Client.new)
end

