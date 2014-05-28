class KarmasController < ApplicationController
  authorize_resource

  before_action :signed_in_user, only: [:create]

  def create
    @object = params[:object].constantize.find(params[:id])

    if user_karma = @object.karmas.find_by(user: current_user)
      unless user_karma.value.to_s == params[:value].to_s
        @object.karmas.find_by(user: current_user).destroy
      end
    else
      @object.karmas.create(value: params[:value], user: current_user)
    end

    if params[:friendly_fwd].present?
      flash[:success] = "Sucessfully voted."
    end
  end
end
