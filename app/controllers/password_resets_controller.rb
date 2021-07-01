class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update] # Case (1)

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      render json: { "message": "Email sent with password reset instructions" }
    else
      render json: { "message": "Email address not found" }
    end
  end

  def update
    if params[:user][:password].empty? # Case (3)
      @user.errors.add(:password, "can't be empty")
      render json: { error: user.errors.messages }, status: 322
    elsif @user.update(user_params) # Case (4)
      log_in @user
      render json: { "message": "Password has been reset." }, status: 322
    else
      render json: { "message": "Password has not been reset" } # Case (2)
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # Confirms a valid user.
  def valid_user
    unless @user && @user.activated? &&
      @user.authenticated?(:reset, params[:id])
      render json: { error: user.errors.messages }, status: 322
    end
  end

  # Checks expiration of reset token.
  def check_expiration
    if @user.password_reset_expired?
      render json: { "message": "Password reset has expired." }, status: 322
    end
  end

end
