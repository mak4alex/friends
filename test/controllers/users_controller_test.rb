require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { domain: @user.domain, first_name: @user.first_name, hidden: @user.hidden, last_name: @user.last_name, photo_100: @user.photo_100, photo_400_orig: @user.photo_400_orig, photo_50: @user.photo_50, screen_name: @user.screen_name, sex: @user.sex, status: @user.status, vk_user_id: @user.vk_user_id } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { domain: @user.domain, first_name: @user.first_name, hidden: @user.hidden, last_name: @user.last_name, photo_100: @user.photo_100, photo_400_orig: @user.photo_400_orig, photo_50: @user.photo_50, screen_name: @user.screen_name, sex: @user.sex, status: @user.status, vk_user_id: @user.vk_user_id } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
