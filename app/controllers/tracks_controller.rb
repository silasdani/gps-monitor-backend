class TracksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:index, :update, :destroy, :getData]

  def index
    tracks = Track.all

    render json: TrackSerializer.new(tracks).as_json
  end

  def my 
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
  
  def show
    track = Track.find(params[:id])
    render json: TrackSerializer.new(track).as_json
  end
  
  def weekly_report
    today = Date.today
    this_week_report =  report_on(today.at_beginning_of_week, today.at_end_of_week)
    last_week_report =  report_on(today.last_week, today.at_beginning_of_week)
    week_before_last_week_report =  report_on(today.last_week.last_week, today.last_week)

    last_last_week = today.last_week.last_week
    last_week = today.last_week
    this_week = today.at_beginning_of_week
    
    render json: {
      this_week_report: {week: this_week, distance: this_week_report[0], time: this_week_report[1], av_speed: this_week_report[2]},
      last_week_report: {week: last_week, distance: last_week_report[0], time: last_week_report[1], av_speed: last_week_report[2]},
      week_before_last_week_report: {week: last_last_week, distance: week_before_last_week_report[0], time: week_before_last_week_report[1], av_speed: week_before_last_week_report[2]},
    }
  end


  private
  def track_params
    params.require(:track).permit(:date, :distance, :time, :user_id)
  end

  def correct_user
    @track = current_user.tracks.find_by(id: params[:id])
    render json: { "message": "You can't do that, you're not admin or correct user" }, status: 422 if @track.nil? && !current_user.admin?
  end

  def report_on(dateFrom, dateTo)
    tracks = Track.where("user_id = ? AND date > ? AND date < ?  ", current_user.id, dateFrom, dateTo)
  
    total_distance = 0
    total_time = 0
    total_av_speed = 0

    tracks.each do |t|
      total_distance += t.distance
      total_time += t.time
      total_av_speed += t.av_speed
    end

    return total_distance.round(2), total_time, total_time>0 ? total_av_speed/tracks.length : 0
  end

end
