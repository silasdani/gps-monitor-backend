class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    token = AuthenticationTokenService.auth(user)

    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        remember(user)
        render json: {token: token}, status: 201
      else
        message = "Account not activated "
        message += "Check your email for the activation link."

        render json: { error: user.errors.messages, message: message  }
      end
    else
      render json: { error: "Invalid email or password"  }, status: 401
    end
  end

  def destroy
    log_out if logged_in?
    render json: {"message": 'Successfully logged out'}
  end

  def ping
    render json: {"ping": "pong"}, status: 200 
  end

  private

  def options
    @options ||= { include: %i[locations] }
  end

end
