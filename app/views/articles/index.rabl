collection :@articles
attributes :id, :slug, :title, :content, :published_at, :created_at,
           :updated_at, :type

child :user do
  attributes :id, :email, :name, :slug, :avatar_url
end

child :comments do
  attributes :id, :text, :created_at, :updated_at

  child :user do
    attributes :id, :banned_at
  end
end
