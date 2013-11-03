class KarmasController < ApplicationController
  authorize_resource

  def create
    @object = params[:object].constantize.find(params[:id])

    unless @object.karmas.where(user: current_user).count > 0
      @object.karmas.create(value: params[:value], user: current_user)
    end
  end
  
  def destroy
    @object = params[:object].constantize.find(params[:id])

    @object.karmas.find_by(user: current_user).destroy
  end
end
