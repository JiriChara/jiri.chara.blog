module Api
  class HomeController < ApiController
    def index
      render json: { message: 'Hello ;-)' }
    end
  end
end
