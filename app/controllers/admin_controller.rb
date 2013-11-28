class AdminController < ApplicationController
  authorize_resource class: false

  def index
  end

  def access_info
    @access_infos = AccessInfo.all
  end
end
