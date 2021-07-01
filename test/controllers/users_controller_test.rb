require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:daniel)
    @other_user = users(:lana)
    @manager_user = users(:archer)
    @simple_user = users(:lana)
    @daniels_track = tracks(:one)
  end

  # test "should get new" do
  #   get signup_path
  #   assert_response :success
  # end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
      user: { password: "password",
              password_confirmation: "password",
              admin: true
      } }

  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "shold redirect index when logged in as a non-admin" do
    log_in_as(@other_user)
    get users_path
    assert_redirected_to root_url
  end

  test "should not allow deleting someone else's track when logged in as manager or non-admin" do
    log_in_as (@manager_user)
    assert_no_difference 'Track.count' do
      delete track_path(@daniels_track)
    end
    assert_redirected_to root_url
  end

  test "should not allow adding someone else a track when logged in as manager or non-admin" do
    log_in_as(@simple_user)
    assert_not @simple_user.admin?
    
    assert_no_difference 'Track.count' do
    post tracks_path, params: {
      "track": {
          date: "2021-06-27T05:07:04.000Z",
          distance: 5.23,
          time: 1000,
          user_id: @user.id } }
    end
  end

end

