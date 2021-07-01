require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:daniel)
    @other_user = users(:lana)
    @manager_user = users(:archer)
    @simple_user = users(:lana)
    @daniels_track = tracks(:one)
  end

  test "index action should be succes when logged in as admin/manager" do
    log_in_as(@user)
    get users_path
    assert_response :success

    log_in_as(@manager_user)
    get users_path
    assert_response :success
  end

  test "index action should be fail when logged in as simple user" do
    log_in_as(@simple_user)
    get users_path
    assert_response :success
  end

  # test "should redirect edit when not logged in" do
  #   get edit_user_path(@user)
  # end

  # test "should redirect edit when logged in as wrong user" do
  #   log_in_as(@other_user)
  #   get edit_user_path(@user)
  # end

  # test "should redirect update when logged in as wrong user" do
  #   log_in_as(@other_user)
  #   patch user_path(@user), params: { user: { name: @user.name,
  #                                             email: @user.email } }
    
  # end

  # test "should redirect index when not logged in" do
  #   get users_path
  #   assert_redirected_to login_url
  # end

  # test "should redirect update when not logged in" do
  #   patch user_path(@user), params: { user: { name: @user.name,
  #                                             email: @user.email } }

  # end



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
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
  end

  test "shold redirect index when logged in as a non-admin" do
    log_in_as(@other_user)
    get users_path
  end

  test "should not allow deleting someone else's track when logged in as manager or non-admin" do
    log_in_as (@manager_user)
    assert_no_difference 'Track.count' do
      delete track_path(@daniels_track)
    end
  end

end

