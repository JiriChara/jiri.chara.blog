object false

child(:@articles) do
  attributes :id, :title, :content, :slug, :published_at, :type, :created_at,
    :updated_at

  child :author do
    attributes :id, :email, :name, :avatar_url, :slug, :banned_at
  end

  node(:comments_count) { |article| article.comments.count }
end

node(:meta) do
  paginate @articles
end
