require 'test_helper'

class TokenTest < ActiveSupport::TestCase

  def setup
    @user = users(:bijiabobo)
    @token = @user.tokens.build(token:"xsfsdkrvjker", name: "iPhone 6")
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

  test "token should only has letter number and underline" do
    @token.token = "喵"*10
    assert_not @token.valid?
    @token.token = "?sfEd_sad3_sWaf3="
    assert_not @token.valid?
    @token.token = "sfEd_sad3_sWaf3"
    assert @token.valid?
  end

  # test name

  test "name should be presence" do
    assert @token.valid?
    @token.name = "    "
    assert_not @token.valid?
  end

end
