module Paginator

  def paginate args
    set_args args
    self
  end

  def set_args args
    @args = args
  end

  def paginate_page
    @args[:page] || 1
  end

  def paginate_per_page
    @args[:per_page] || Kaminari::config.default_per_page
  end

  def paginate_sort
    @args[:sort] || "created_at"
  end

  def paginate_order
    @args[:order] || "desc"
  end

  def result
    self.page(paginate_page).per(paginate_per_page).order("#{paginate_sort} #{paginate_order}")
  end

  def meta
    {
      current_page: result.current_page,
      next_page: result.next_page,
      prev_page: result.prev_page,
      total_pages: result.total_pages,
      total_count: result.total_count,
      sort: paginate_sort,
      order: paginate_order
    }
  end

end
