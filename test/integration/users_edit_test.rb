require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:bijiabobo)
  end

  test "unsuccessful edit" do
    log_in_as @user

    get edit_user_path @user
    patch user_path(@user), user: {
      name: "",
      email:"sdfahkwr23@xxx.com",
      password: "aw31",
      password_confirmation: "w23enf"
    }
    assert_template "users/edit"
  end

  test "successful edit with firendly forwarding" do
    get edit_user_path @user
    log_in_as @user
    assert_redirected_to edit_user_path @user

    newName = "sadfjbwk"
    newEmail = "fnsjjn32enfd@fdsgj.com"

    patch user_path(@user), user: {
      name: newName,
      email: newEmail,
      password: "",
      password_confirmation: ""
    }

    assert_not flash.empty?
    assert_redirected_to @user

    @user.reload
    assert_equal @user.name, newName
    assert_equal @user.email, newEmail
  end

end
