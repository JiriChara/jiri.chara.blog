class AdminController < ApplicationController
  authorize_resource class: false

  def index
  end

  def access_info
    respond_to do |format|
      format.html
      format.json { render json: AccessInfoDatatable.new(view_context) }
    end
  end
end
