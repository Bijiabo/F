require 'test_helper'

class TokenTest < ActiveSupport::TestCase

  def setup
    @token = tokens(:bijiabobo)
    @token.save
  end

  # test token

  test "token should be presence" do
    assert @token.valid?
    @token.token = "   "
    assert_not @token.valid?
  end

  test "token's length should between 8 to 255" do
    @token.token = "x"
    assert_not @token.valid?
    @token.token = "x"*250
    assert @token.valid?
    @token.token = "x"*256
    assert_not @token.valid?
  end

  test "should return correct user for token" do
    user = Token.authenticate(@token.token)
    assert_not user == nil
    assert_equal user.id, @token.user.id
  end

  # test name

  test "name should be presence" do
    assert @token.valid?
    @token.name = "    "
    assert_not @token.valid?
  end

end
