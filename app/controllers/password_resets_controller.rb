class PasswordResetsController < ApplicationController 
  before_action :get_user, only: :update 
  before_action :valid_user, only: :update
  before_action :check_expiration, only: :update



  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      # @user.send_password_reset_email
      render json: { "message": "Email sent with password reset instructions", reset_digest: @user.reset_digest }
    else
      render json: { "message": "Email address not found" }, status: 404
    end
  end

  def update
    user = User.find_by(reset_digest: params[:reset_digest])
    if user.update(user_params)
      render json: { "message": "Password has been reset." }
    else
      render json: { "message": "Password has not been reset" }, status: 322
    end
  end

  def validate_token 
    @user = User.find_by(reset_digest: params[:reset_digest])
    if @user
      render json: {succes: true}
    else
      render json: {succes: false}, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(reset_digest: params[:reset_digest])
  end

  # Confirms a valid user.
  def valid_user
    unless @user && @user.activated? 
      render json: {"message": "User might not be activated!" }, status: 322
    end
  end

  # Checks expiration of reset token.
  def check_expiration
    if @user.password_reset_expired?
      render json: { "message": "Password reset has expired." }, status: 322
    end
  end

end
