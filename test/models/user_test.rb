require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new name: 'Bijiabo', email: 'bijiabo@gmail.com', password: '123456', password_confirmation: '123456'
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'user name should not be toooooo long' do
    @user.name = "x"*51
    assert_not @user.valid?
  end

  test 'user email address should not be too looooong' do
    @user.email = "x"*250+"@xx.com"
    assert_not @user.valid?
  end

  test 'user email format vaild' do
    @user.email = "23jk4g1524egr7wgxxx@xxx.com"
    assert @user.valid?

    @user.email = "xxxxx"
    assert_not @user.valid?

    @user.email = "@xxx.com"
    assert_not @user.valid?
  end

  test 'email should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "xXXXXxxxxxxXXXxx@XxxXXXxx.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'password should be present (noblank)' do
    @user.password = @user.password_confirmation = " "*6
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = "x"*5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
end
