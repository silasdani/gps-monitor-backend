class RaceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :distance, :time
end
