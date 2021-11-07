class Track < ApplicationRecord
  belongs_to :user
  before_save :compute_av_speed

  default_scope -> { order(date: :desc) }
  validates :user_id, :distance, :date, :location, presence: true

  private
  def compute_av_speed
    self.av_speed = self.time != 0 ? (self.distance*3600/self.time).round(2) : 0.0
  end
end
