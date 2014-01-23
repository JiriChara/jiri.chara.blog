class TagsController < ApplicationController
  authorize_resource

  def index
    @tags = Tag.all
  end

  def edit
    @tag = Tag.find_by(slug: params[:id])
  end

  def update
    @tag = Tag.find_by(slug: params[:id])

    if @tag.update(tag_params)
      flash[:success] = "Tag was successfully updated."
      redirect_to tags_path
    else
      render :edit
    end
  end

  def destroy
    @tag = Tag.find_by(slug: params[:id])

    @tag.destroy

    flash[:success] = "Tag successfully deleted."

    redirect_to tags_path
  end

private
  def tag_params
    params.require(:tag).permit(:name, :slug)
  end
end
