Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, CONFIG[:omniauth][:facebook][:key],
    CONFIG[:omniauth][:facebook][:secret]

  provider :github, CONFIG[:omniauth][:github][:key],
    CONFIG[:omniauth][:github][:secret], scope: 'user'

  provider :google_oauth2,
    CONFIG[:omniauth][:google][:key], CONFIG[:omniauth][:google][:secret]
end
