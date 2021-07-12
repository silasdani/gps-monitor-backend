class TrackSerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :distance, :time, :user_id, :av_speed

end
