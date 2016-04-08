class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from ArgumentError, with: :invalid_argument
 
  private
 
    def invalid_argument
      render nothing: true, status: :bad_request
    end
end
