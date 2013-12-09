class AccessInfoDatatable
  delegate :params, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(opts={})
    {
      sEcho:                params[:sEcho].to_i,
      iTotalRecords:        AccessInfo.count,
      iTotalDisplayRecords: access_info.count,
      aaData:               data
    }
  end

private
 def data
   access_info.map do |ai|
     [
       ai.updated_at.strftime("%Y-%m-%d @ %H:%M"),
       ai.ip,
       "#{ai.browser} v. #{ai.version}",
       ai.platform,
       ai.users ? ai.users.collect(&:name_or_email).join(', ') : "none",
       ai.get_country,
       ai.get_city
     ]
   end
 end

 def access_info
   @access_info ||= fetch_access_info
 end

 def fetch_access_info
   case sort_column
   when "user"
     res = AccessInfo.includes(:users).order("users.name #{sort_direction}")
   else
     res = AccessInfo.order(sort_column => sort_direction.to_sym)
   end

   if params[:sSearch].present?
     res = res.where("ip like :search or platform like :search", search: "%#{params[:sSearch]}%")
   end

   res = res.page(page).per(per_page)

   res
 end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[updated_at ip browser platform user country city]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
