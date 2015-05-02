module Api
  class ErrorsController < ApiController
    def raise_not_found!
      raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
    end
  end
end
