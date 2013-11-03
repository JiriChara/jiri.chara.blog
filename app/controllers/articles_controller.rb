class ArticlesController < ApplicationController
  authorize_resource

  rescue_from ActiveRecord::RecordNotFound, with: ->() {
    flash[:error] = "Article not found."
    redirect_to oops_path(status: 404)
  }

  def index
    @tag = Tag.find(params[:tag_id]) if params[:tag_id]
    @articles = (@tag ? @tag.articles : Article).
      only_articles.published.order(published_at: :desc).
      page(params[:page]).per(Article::DEFAULT_PER_PAGE)
  end

  def unpublished
    @articles = Article.unpublished.page(params[:page]).
      per(Article::DEFAULT_PER_PAGE)

    render :unpublished
  end

  def show
    @article = Article.find_by(slug: params[:id])
  end

  def new
    @article = if params[:type].present?
      params[:type].constantize.new(type: params[:type])
    else
      Article.new(type: "Article")
    end
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      flash[:success] = "Article successfully created."

      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def edit
    @article = Article.find_by(slug: params[:id])
  end

  def update
    @article = Article.find_by(slug: params[:id])

    if @article.update(article_params)
      flash[:success] = "Article was successfully updated."
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find_by(slug: params[:id])

    @article.destroy

    flash[:success] = "Article successfully deleted."

    redirect_to articles_path
    # render js: "window.location.href = '/';"
  end

  def publish
    @article = Article.find_by(slug: params[:id])

    @article.publish!
    flash[:success] = "Article was successfully published."
    redirect_to articles_path
  end

  def unpublish
    @article = Article.find_by(slug: params[:id])

    @article.unpublish!
    flash[:success] = "Article was successfully unpublished."
    redirect_to unpublished_articles_path
  end

private
  def article_params
    params.require(:article).permit(:title, :content, :type, :tag_list)
  end
end
