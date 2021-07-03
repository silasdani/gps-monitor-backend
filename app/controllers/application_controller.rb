class ApplicationController < ActionController::Base
  include SessionsHelper
  skip_before_action :verify_authenticity_token
  

  private
  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      render json: { message: "Log in first!" }, status: 322
    end
  end
end