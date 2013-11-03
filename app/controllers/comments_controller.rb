class CommentsController < ApplicationController
  authorize_resource

  before_action :signed_in_user, only: [:create]

  def new
    @comment = Comment.new(parent_id:  params[:parent_id])
  end

  def create
    @comment = current_user.comments.create(comment_params)

    if @comment.persisted?
      msg = "Comment was successfully created."

      if params[:friendly_fwd].present?
        flash[:success] = msg
      else
        flash.now[:success] = msg
      end

      render :create
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      flash.now[:success] = "Comment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    flash.now[:success] = "Comment was successfully deleted."
    @comment.destroy
  end

private
  def comment_params
    params.require(:comment).permit(:text, :article_id, :parent_id)
  end
end
