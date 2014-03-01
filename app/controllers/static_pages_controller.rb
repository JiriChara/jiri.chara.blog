class StaticPagesController < ApplicationController
  authorize_resource class: false

  def about
    @about = About.where(type: "About").actual
  end

  def cv
    @cv = CV.where(type: "CV").actual
  end

  def oops
    @status  = session.delete(:error_code)
  end
end
