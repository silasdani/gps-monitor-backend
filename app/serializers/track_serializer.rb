class TrackSerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :distance, :time
end
