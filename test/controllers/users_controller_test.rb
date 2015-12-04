require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:bijiabobo)
    @other_user = users(:xxx)
    @admin = users(:admin)
  end

  # update and edit

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

  test "should return error message when not logged in for edit user info json request" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email}, format: :json
    result = JSON.parse @response.body
    assert result["error"]
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

  test "should edit success for json request" do
    patch :update, {
        id: @user.id,
        token: tokens(:bijiabobo).token,
        user: {
            name: "xxxafdjsekwfas3",
            email: @user.email,
            password: "",
            password_confirmation: ""
        },
        format: :json
    }
    result = JSON.parse @response.body
    assert result["success"]
  end

  # login actions

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

  # show page

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

  test "user show page should display error while the account is not exist" do
    user = User.new name: 'Bijiabo', email: 'bijiabo@gmail.com', password: '123456', password_confirmation: '123456'
    user.save
    user.destroy
    get :show, id: user
    assert_redirected_to error_url

    get :show, id: user, :format => :json
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert resultJSON["error"]
  end

  test "should return user data for json request with correct token" do
    get :index, token: tokens(:admin).token, format: :json
    reslutJSON = ActiveSupport::JSON.decode @response.body
    assert reslutJSON.length > 0
  end

  # relationship actions

  test "should redirect following when not logged in" do
    get :following, id: @user
    assert_redirected_to login_url

    get :following, id: @user, format: :json
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert resultJSON["error"]
  end

  test "should redirect followers when not logged in" do
    get :followers, id: @user
    assert_redirected_to login_url

    get :followers, id: @user, format: :json
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert resultJSON["error"]
  end

end
