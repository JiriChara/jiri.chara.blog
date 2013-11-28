class TagsController < ApplicationController
  authorize_resource

  def index
    @tags = Tag.all
  end

  def destroy
    @tag = Tag.find(params[:id])

    @tag.destroy

    flash[:success] = "Tag successfully deleted."

    redirect_to tags_path
  end
end
