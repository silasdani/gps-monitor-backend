require "test_helper"

class TrackTest < ActiveSupport::TestCase
  def setup
    @user = users(:daniel)
    @track = @user.tracks.build(date: Time.zone.now, distance: 15.2, time: 20*60)
  end

  test "should be valid" do
    assert @track.valid?
  end

  test "user id should be present" do
    @track.user_id = nil
    assert_not @track.valid?
  end

  test "order should be most recent first" do
    assert_equal tracks(:most_recent), Track.first
  end
end
