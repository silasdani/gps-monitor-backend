class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :update, :destroy, :add_location]
  before_action :correct_user, only: [:update, :show, :add_location]
  before_action :admin_user_or_manager, only: [:index, :destroy]

  # CRUD operations

  def index
    @users = User.where("NOT admin")
    render json: UserSerializer.new(@users).serialized_json
  end

  def show
    @user = User.find(params[:id])
    render json: UserSerializer.new(@user, options).serialized_json
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.send_activation_email
      render json: UserSerializer.new(@user).serialized_json
    else
      render json: { error: @user.errors.messages }, status: 422
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params_update)
      render json: UserSerializer.new(@user).serialized_json
    else
      render json: { error: @user.errors.messages }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    if current_user.manager? && user.admin?
      render json: { error: "You cannot delete a admin user!"}, status: 401
    elsif user.destroy
      head :no_content
    else
      render json: { error: user.errors.messages }, status: 422
    end

  end

  def add_location
    @user = User.find(params[:id])
    if @user.locations.create!(user_location_params)
      render json: { location: "Location has been added!" }, status: 200
    elsif
      render json: { erroe: "Location hasn't been added!" }, status: 422
    end
  end

  private

  def user_params_update
    if current_user.admin?
      params.require(:user).permit(:name, :email, :manager, :admin, :activated)
    else
      params.require(:user).permit(:name, :email, :manager, :activated)
    end
  end

  def user_location_params
    params.require(:location).permit(:location_title, :street_number, :locality, :postal_code, :latitude, :longitude, :place_id, :country, :facility_name)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Includes the tracks as options
  def options
    @options ||= { include: %i[locations] }
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    render json: { "message": "You can't do that" }, status: 322 unless (current_user?(@user) || current_user.admin? || current_user.manager?)
  end

  #Confirms an admin user.
  def admin_user_or_manager
    render json: { "message": "You can't do that, you're not a admin or manager" } unless current_user.admin? || current_user.manager?
  end

end
