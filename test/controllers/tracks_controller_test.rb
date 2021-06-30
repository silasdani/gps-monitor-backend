require 'test_helper'

class TracksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @track = tracks(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Track.count' do
      post tracks_path, params: { track: {
        "date": "2021-06-27T05:07:04.000Z",
        "distance": 5.23,
        "time": 1000
      } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Track.count' do
      delete track_path(@track)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong track" do
    log_in_as(users(:daniel))
    track = tracks(:three)
    assert_no_difference 'Track.count' do
      delete track_path(track)
    end
    assert_redirected_to root_url
  end
end
