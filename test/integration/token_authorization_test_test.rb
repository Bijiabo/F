require 'test_helper'

class TokenAuthorizationTestTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bijiabobo)
    @token = tokens(:bijiabobo)
    @fakeToken = "fake_authorization_token"
  end

  test "should get user data for correct token" do
    user = Token.authenticate(@token.token)
    assert_not user == nil
    assert_equal user.id, @token.user.id
  end

  test "should get nil for incorrect token" do
    user = Token.authenticate(@fakeToken)
    assert user == nil
  end

  test "should show users list for correct token" do
    # web request
    get users_url, token: @token.token
    assert_template 'users/index'

    # application client request
    get users_url, token: @token.token, format: 'json'
    users = JSON.parse @response.body

    assert_not users[0]["name"] == nil
  end

  test "should not show users list for incorrect token" do
    # web request
    get users_url, token: @fakeToken
    assert_redirected_to login_path

    # application client request
    get users_url, token: @fakeToken, :format => :json
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert_equal resultJSON["error"], true
  end

end
