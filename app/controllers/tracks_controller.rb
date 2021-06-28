class TracksController < ApplicationController
    # before_action :logged_in_user, only: [:create, :destroy]
    # before_action :correct_user, only: :destroy
    protect_from_forgery with: :null_session
    
    def index
        tracks = Track.all

        render json: TrackSerializer.new(tracks).serialized_json
    end

    def create
        track = Track.new(track_params)

        if(track.save) 
            render json: TrackSerializer.new(track).serialized_json
        else
            render json: { error: track.errors.messages }, status: 422
        end
    end

    def update
        track = Track.find(params[:id])

        if track.update(track_params)
            render json: TrackSerializer.new(track).serialized_json
        else
            render json: { error: track.errors.messages }, status: 422
        end
    end

    def destroy
        track = Track.find(params[:id])

        if(track.destroy) 
            head :no_content
        else
            render json: { error: track.errors.messages }, status: 422
        end
    end

    private
        def track_params
            params.require(:track).permit(:date, :distance, :time, :user_id)
        end
end
