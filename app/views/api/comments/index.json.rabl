collection :@comments

attributes :id, :text, :created_at, :updated_at, :karma

child :author do
  attributes :id, :email, :name, :slug, :banned_at, :avatar
end

child :karmas do
  attributes :id, :value, :created_at, :updated_at
end
