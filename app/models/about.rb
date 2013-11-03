class About < Article
  class << self
    def actual
      self.published.order(published_at: :asc).first
    end
  end
end
