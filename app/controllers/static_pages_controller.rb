class StaticPagesController < ApplicationController
  authorize_resource class: false

  def about
    @about = About.actual
  end

  def cv
    @cv = CV.actual
  end

  def oops
    @status = params[:status] if params[:status]
  end
end
