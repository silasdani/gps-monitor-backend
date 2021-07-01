class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        render json: UserSerializer.new(user).serialized_json
      else
        message = "Account not activated. \n"
        message += "Check your email for the activation link."

        render json: { error: user.errors.messages, message: message  }, status: 322
      end
    else
      render json: {"message": 'Invalid email/password combination'}
    end
  end

  def destroy
    log_out if logged_in?
    render json: {"message": 'Successfully logged out'}
  end

end
