class CV < Article
  class << self
    def actual
      self.published.order(published_at: :desc).first
    end
  end
end
