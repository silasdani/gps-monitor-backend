class LocationsController < ApplicationController
    before_action :logged_in_user

    def add_location
        if @current_user.locations.create!(location_params)
          render json: LocationSerializer.new(@current_user.locations.last).serialized_json
        elsif
          render json: { erroe: "Location hasn't been added!" }, status: 422
        end
      end

      private

      def location_params
        params.require(:location).permit(:location_title, :street_number, :locality, :postal_code, :latitude, :longitude, :place_id, :country, :facility_name)
      end
end
