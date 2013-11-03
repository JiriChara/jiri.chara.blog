class UsersController < ApplicationController
  authorize_resource

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(slug: params[:id])
  end

  def edit
    @user = User.find_by(slug: params[:id])
  end

  def update
    @user = User.find_by(slug: params[:id])

    if @user.update_attributes(params[:User])
      flash[:success] = "Profile was successfully updated."
      redirect_to @user
    else
      render :edit
    end
  end

  def ban
    @user = User.find_by(slug: params[:id])

    @user.ban!
    redirect_to @user
  end

  def unban
    @user = User.find_by(slug: params[:id])

    @user.unban!
    redirect_to @user
  end
end
