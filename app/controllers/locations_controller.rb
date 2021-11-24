class LocationsController < ApplicationController
    before_action :logged_in_user
    before_action :correct_user, only: [:show]

    def locations 
      @locations = @current_user.locations

      render json: LocationSerializer.new(@locations).serialized_json
    end

    def show
      user = User.find(params[:id])
      @locations = user.locations;
      render json: LocationSerializer.new(@locations).serialized_json
    end

    def add_location
      if @current_user.locations.create!(location_params)
        render json: LocationSerializer.new(@current_user.locations.last).serialized_json
      elsif
        render json: { erroe: "Location hasn't been added!" }, status: 422
      end
    end

    def get_user_locations 
      user = User.find(params[:id])
      start_time = date_params[:start_time]
      end_time = date_params[:end_time]
      @locations = user.locations
      @locations = @locations.where("created_at >= ? AND created_at <= ?", start_time, end_time);

      render json: LocationSerializer.new(@locations).serialized_json
    end

    private

    def location_params
      params.require(:location).permit(:location_title, :street_number, :locality, :postal_code, :latitude, :longitude, :place_id, :country, :facility_name)
    end

    def date_params
      params.require(:date).permit(:start_time, :end_time)
    end


    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      render json: { "message": "You can't do that" }, status: 322 unless (current_user?(@user) || current_user.admin? || current_user.manager?)
    end
end
