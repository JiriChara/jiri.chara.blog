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

    def create
      raise CanCan::AccessDenied if current_user.nil?

      @comment = current_user.comments.create(comment_params)

      if @comment.save
        render json: @comment, status: 201, location: @comment
      else
        render json: @comment.errors, status: 422
      end
    end

  private
    def comment_params
      params.require(:comment).permit(:text, :article_id, :parent_id)
    end
  end
end
