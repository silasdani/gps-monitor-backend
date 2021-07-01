class AccountActivationsController < ApplicationController
    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
            user.activate
            render json: UserSerializer.new(user).serialized_json
        else
            render json: { error: user.errors.messages }, status: 322
        end
    end
end
