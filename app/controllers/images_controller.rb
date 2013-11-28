class ImagesController < ApplicationController
  authorize_resource

  def index
    @images = if params[:article_id].present?
      @article = Article.find_by(slug: params[:article_id])
      @article.images
    else
      Image.all
    end

    render json: @images.collect { |i| i.to_jq_upload }.to_json
  end

  def create
    if params[:image][:image].is_a?(Array)
      params[:image][:image] = params[:image][:image][0]
    end

    @image = Image.new(params.require(:image).permit(:image, :article_id))

    if @image.save
      respond_to do |format|
        format.html do
          render json: [@image.to_jq_upload].to_json,
            content_type: "text/html",
            layout: false
        end

        format.json do
          render json: [@image.to_jq_upload].to_json
        end
      end
    else
      render json: [{ error: "Upload failure" }], status: 304
    end
  end

  def destroy
    @image = Image.find(params[:id])

    @image.destroy

    render json: true
  end
end
