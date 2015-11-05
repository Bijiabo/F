require 'test_helper'

class TokenAuthorizationTestTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bijiabobo)
    @token = tokens(:bijiabobo)
    @fakeToken = "fake_authorization_token"
  end

  test "shoud vaild" do
    assert @token.valid?
  end

  test "should get user data for correct token" do
    token = Token.authenticate(@token.token)
    assert_not token == nil
    assert_equal token.user.id, @token.user.id
  end

  test "should get nil for incorrect token" do
    user = Token.authenticate(@fakeToken)
    assert user == nil
  end

end
