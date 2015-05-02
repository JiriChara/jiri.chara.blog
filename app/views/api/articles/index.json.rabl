collection :@articles

attributes :id, :title, :content, :slug, :published_at, :type, :created_at,
  :updated_at

child :author do
  attributes :id, :email, :name, :avatar_url, :slug, :banned_at
end
