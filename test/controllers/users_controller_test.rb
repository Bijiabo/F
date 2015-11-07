require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:bijiabobo)
    @other_user = users(:xxx)
    @admin = users(:admin)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_redirected_to root_url
  end

  test "should redirect index page when user did not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should show users page link in header when user logged in" do
    log_in_as @user
    get :index
    assert_select "a[href=?]", users_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, id: @other_user, user: { password:              "password",
                                            password_confirmation: "password",
                                            admin: true }
    assert_not @other_user.admin?
  end

  test "user show page should not display when is not owner user" do
    log_out
    get :show, id: @user
    assert_select "a[href=?]", edit_user_path, count: 0

    log_in_as @other_user
    get :show, id: @user
    assert_select "a[href=?]", edit_user_path, count: 0
  end

  test "user show page should display edit link when is owner user" do
    log_in_as @user
    get :show, id: @user
    assert_template 'users/show'
    assert_select "a[href=?]", edit_user_path
  end

  # for application client register api
  test "should not create a new user for application client api when lack verificationString" do
    post :register_new_user, {email: 'bijiabo@gmail.com', name: 'bijiabo', password: 'password'}
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert_equal resultJSON["error"], true
  end

  test "should create a new user for application client api when send correct data" do
    email = "bijiabo@gmail.com"
    verificationString = Digest::SHA1.hexdigest( email + ENV["Secret_key"] )
    post :register_new_user, {email: email, name: 'bijiabo', password: 'password', password_confirmation: 'password', verification: verificationString}
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert_equal resultJSON["success"], true
  end

  test "should not create a new user for application client api when send incorrect data" do
    email = "bijiabo@gmail.com"
    verificationString = Digest::SHA1.hexdigest( email + ENV["Secret_key"] )
    post :register_new_user, {emailx: email, name: 'bijiabo', password: 'password', password_confirmation: 'password', verification: verificationString}
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert_equal resultJSON["error"], true
  end

  test "should not create a new user for application client api when send incorrect verificationString" do
    email = "bijiabo@gmail.com"
    verificationString = "hello,world."
    post :register_new_user, {emailx: email, name: 'bijiabo', password: 'password', password_confirmation: 'password', verification: verificationString}
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert_equal resultJSON["error"], true
  end

end
