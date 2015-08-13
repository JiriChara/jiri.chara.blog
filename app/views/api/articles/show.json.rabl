object :@article

attributes :id, :title, :content, :slug, :published_at, :type, :created_at,
  :updated_at

child :author do
  attributes :id, :email, :name, :avatar, :slug, :banned_at
end
