require 'test_helper'

class TokensControllerTest < ActionController::TestCase

  def setup
    @user = users(:bijiabobo)
    @token = tokens(:bijiabobo)
  end

  test "should get token list for current user" do
    # web request
    log_in_as @user
    get :index
    assert_template 'index'

    # application request
    log_out
    get :index, {:format => :json, token: @token.token }
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert resultJSON["user"]["name"] == @token.user.name
    assert resultJSON["user"]["email"] == @token.user.email
  end

  test "should not get token list for user who did not logged in" do
    # web request
    get :index

    # application request
    get :index, :format => :json
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert resultJSON["error"] == true
  end

  test "should get new token when use correct email, password, deviceName and deviceId" do
    user = User.new name: 'Bijiabo', email: 'bijiabo@gmail.com', password: '123456', password_confirmation: '123456'
    assert user.save
    post :request_new_token, {email: user.email, password: user.password, deviceName: 'iPhone 6', deviceID: 'zaq-xsw-cde-vfr'}
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert user.email == resultJSON["email"]
    assert user.id == resultJSON["token"]["user_id"]
  end

  test "should not get a new token when did not give deviceName or deviceId" do
    user = User.new name: 'Bijiabo', email: 'bijiabo@gmail.com', password: '123456', password_confirmation: '123456'
    assert user.save

    post :request_new_token, {email: user.email, password: user.password, deviceName: 'iPhone 6'}
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert resultJSON["error"] == true

    post :request_new_token, {email: user.email, password: user.password, deviceID: 'zaq-xsw-cde-vfr'}
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert resultJSON["error"] == true

  end

  test "should reset token when request token for the same deviceID" do

    user = User.new name: 'Bijiabo', email: 'bijiabo@gmail.com', password: '123456', password_confirmation: '123456'
    assert user.save

    deviceID = 'zaq-xsw-cde-vfr'
    post :request_new_token, {email: user.email, password: user.password, deviceName: 'iPhone 6', deviceID: deviceID}
    resultJSON = ActiveSupport::JSON.decode @response.body
    previous_token = resultJSON["token"]["token"]

    post :request_new_token, {email: user.email, password: user.password, deviceName: 'iPhone 6', deviceID: deviceID}
    resultJSON = ActiveSupport::JSON.decode @response.body
    new_token = resultJSON["token"]["token"]

    assert_not_equal previous_token, new_token
  end

end
