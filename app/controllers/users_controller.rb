class UsersController < ApplicationController
  # before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  # before_action :correct_user, only: [:edit, :update]
  # before_action :admin_user, only: :destroy

  protect_from_forgery with: :null_session

  def index
      @users = User.all
      render json:  UserSerializer.new(@users, options).serialized_json
      # if logged_in?
      #   @micropost = current_user.microposts.build
      #   @feed_items = current_user.feed.paginate(page: params[:page])
      # end
  end

  def show
    @user = User.find(params[:id])
    render json: UserSerializer.new(@user, options).serialized_json
  end

  def create
    user = User.new(user_params)
    
    if(user.save)
      render json: UserSerializer.new(user).serialized_json
    else
      render json: { error: user.errors.messages }, status: 422
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: UserSerializer.new(@user, options).serialized_json
    else
      render json: { error: @user.errors.messages }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      head :no_content
    else
      render json: {error: user.errors.messages }, status: 422
    end

  end


private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def options
    @options ||= { include: %i[tracks] }
  end


  # Confirms a logged-in user.

  # def logged_in_user
  #   unless logged_in?
  #     store_location
   
  #   end
  # end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  #Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  #Confirms a manager user.
  def manager_user
    redirect_to(root_url) unless current_user.manager?
  end


end
