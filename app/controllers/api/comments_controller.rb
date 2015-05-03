module Api
  class CommentsController < ApiController
    authorize_resource

    def index
      resource = if params[:article_id]
        Article.find(params[:article_id])
      else
        User.find(params[:user_id])
      end

      @comments = resource.comments
    end
  end
end
