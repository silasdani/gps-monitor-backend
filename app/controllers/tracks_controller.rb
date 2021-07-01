class TracksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:index, :show, :update, :destroy]

  def index
    tracks = current_user.tracks

    render json: TrackSerializer.new(tracks).serialized_json
  end

  def show 
    track = Track.find(params[:id])
    render json: TrackSerializer.new(track).serialized_json
  end

  def create
    track = Track.new(track_params)
    track.user_id = current_user.id

    if track.save
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

    if track.destroy
      head :no_content
    else
      render json: { error: track.errors.messages }, status: 422
    end
  end

  private

  def track_params
    params.require(:track).permit(:date, :distance, :time, :user_id)
  end

  def correct_user
    @track = current_user.tracks.find_by(id: params[:id])
    render json: { "message": "You can't do that, you're not admin or correct user" } if @track.nil? && !current_user.admin?
  end
end
