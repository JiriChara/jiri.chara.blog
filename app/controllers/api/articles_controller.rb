module Api
  class ArticlesController < ApiController
    authorize_resource

    respond_to :json

    def index
      tag = Tag.find_by!(slug: params[:tag]) if params[:tag]

      @articles = (tag ? tag.articles : Article).
        only_articles.published.order(published_at: :desc).
        page(params[:page]).per(Article::DEFAULT_PER_PAGE)
    end

    def show
      @article = Article.find(params[:id])
    end

    def create
      article = Article.new(article_params)

      if article.save
        render json: article, status: 201, location: article
      else
        render json: article.errors, status: 422
      end
    end

  private
    def article_params
      params.require(:article).permit(:title, :slug, :content, :type, :tag_list)
    end
  end
end
