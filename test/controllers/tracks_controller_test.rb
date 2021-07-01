require 'test_helper'

class TracksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @track = tracks(:one)
  end

  test "should not be able to create when not logged in" do
    assert_no_difference 'Track.count' do
      post tracks_path, params: { track: {
        "date": "2021-06-27T05:07:04.000Z",
        "distance": 5.23,
        "time": 1000
      } }
    end
  end

  test "should not be able to destroy when not logged in" do
    assert_no_difference 'Track.count' do
      delete track_path(@track)
    end
  end

  test "should CRUD track when admin" do
    log_in_as(users(:daniel))  
    track = tracks(:three)
    
    # Delete
    assert_difference 'Track.count', -1 do
      delete track_path(track)
    end

    # Create
    assert_difference 'Track.count', 1 do
      post tracks_path, params: {
        "track": {
            date: "2021-06-27T05:07:04.000Z",
            distance: 5.23,
            time: 1000,
            user_id: users(:lana).id } }
    end  
  end

  
end
