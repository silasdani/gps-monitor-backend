class TracksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:index, :update, :destroy, :getData]

  def index
    tracks = Track.all

    render json: TrackSerializer.new(tracks).as_json
  end

  def show 
    tracks = current_user.tracks

    render json: TrackSerializer.new(tracks).as_json
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
  
  def getData
    track = Track.find(params[:id])
    render json: TrackSerializer.new(track).as_json
  end
  private

  def track_params
    params.require(:track).permit(:date, :distance, :time, :user_id)
  end

  def correct_user
    @track = current_user.tracks.find_by(id: params[:id])
    render json: { "message": "You can't do that, you're not admin or correct user" }, status: 422 if @track.nil? && !current_user.admin?
  end
end
