module ApiHelper
  def paginate(collection)
    {
      total_items: collection.total_count,
      total_pages: collection.total_pages,
      current_page: collection.current_page,
      page_size: collection.size
    }
  end
end
