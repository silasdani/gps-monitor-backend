class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :'show.html.erb', :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  before_action :manager_user, only: [:destroy]

  def new
    @user = User.new
    render json: { message: "This page is to add a user" }
  end

  def index
    @users = User.all
    render json: UserSerializer.new(@users, options).serialized_json
  end

  def show
    @user = User.find(params[:id])
    render json: UserSerializer.new(@user, options).serialized_json
  end

  def create
    user = User.new(user_params)

    if user.save

      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # render json: UserSerializer.new(user).serialized_json
    else
      render 'new'
      # render json: { error: user.errors.messages }, status: 422
    end
  end

  def edit
    @user = User.find(params[:id])
    render json: { message: "This page is to edit a user" }
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"

      # render json: UserSerializer.new(@user, options).serialized_json
      redirect_to @user
    else
      render 'edit'
      # render json: { error: @user.errors.messages }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      redirect_to users_url
      # head :no_content
    else
      render json: { error: user.errors.messages }, status: 422
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def options
    @options ||= { include: %i[tracks] }
  end

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
