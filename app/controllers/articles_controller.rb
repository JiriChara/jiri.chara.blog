class ArticlesController < ApplicationController
  authorize_resource

  respond_to :html

  rescue_from ActiveRecord::RecordNotFound, with: ->() {
    flash[:error] = "Article not found."
    session[:error_code] = 404
    redirect_to oops_path
  }

  def index
    @tag = Tag.find_by!(slug: params[:tag]) if params[:tag]
    @articles = (@tag ? @tag.articles : Article).
      only_articles.published.order(published_at: :desc).
      page(params[:page]).per(Article::DEFAULT_PER_PAGE)
  end

  def unpublished
    @articles = Article.unpublished.page(params[:page]).
      per(Article::DEFAULT_PER_PAGE_TABLE)

    render :unpublished
  end

  def show
    @article = Article.find_by!(slug: params[:id])
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
      if params[:publish] == "yes"
        @article.publish!
        flash[:success] = "Article successfully created and published."
      else
        flash[:success] = "Article successfully created."
      end

      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def edit
    @article = Article.find_by!(slug: params[:id])
  end

  def update
    @article = Article.find_by(slug: params[:id])

    if @article.update(article_params)
      if params[:publish] == "yes"
        @article.publish!
      end

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

    redirect_to root_path
  end

  def publish
    @article = Article.find_by(slug: params[:id])

    @article.publish!
    flash[:success] = "Article was successfully published."
    redirect_to root_path
  end

  def unpublish
    @article = Article.find_by(slug: params[:id])

    @article.unpublish!
    flash[:success] = "Article was successfully unpublished."
    redirect_to unpublished_articles_path
  end

private
  def article_params
    params.require(:article).permit(:title, :slug, :content, :type, :tag_list)
  end
end
