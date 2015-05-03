collection :@comments

attributes :id, :text, :created_at, :updated_at

child :author do
  attributes :id, :email, :name, :avatar_url, :slug, :banned_at
end
