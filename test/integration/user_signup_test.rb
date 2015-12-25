require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test 'create new user unsuccess' do
    get signup_path

    assert_no_difference 'User.count' do
      post_via_redirect users_path, user: {
        name: '',
        email: 'xxx',
        password: 'xxxxxx',
        password_confirmation: 'x'
      }
    end

    assert_template 'users/new'
    assert_select 'div#error_explanation'
  end

  test 'create new user success' do
    get signup_path

    assert_difference 'User.count', 1 do
      password = 'password'
      post_via_redirect users_path, user: {
        name: 'TestUser',
        email: 'test@tttttt.com',
        password: password,
        password_confirmation: password
      }
    end
    # assert_template 'users/show'
    # assert is_logged_in?
  end

  test 'create new user success by client' do
    assert_difference 'User.count', 1 do
      password = 'password'
      post users_path,
           user: {name: 'TestUser',
                  email: 'test@tttttt.com',
                  password: password,
                  password_confirmation: password},
           format: :json
      resultJSON = ActiveSupport::JSON.decode @response.body
      assert resultJSON["success"]
    end
  end

  test 'create new user success by client unsuccess' do
    assert_no_difference 'User.count' do
      password = 'password'
      post users_path,
           user: {name: 'TestUser',
                  email: 'test@tttttt.com',
                  password: password,
                  password_confirmation: password+"xxx"},
           format: :json
      resultJSON = ActiveSupport::JSON.decode @response.body
      assert resultJSON["error"]
    end
  end

  test 'create new user success by client unsuccess 2' do
    assert_no_difference 'User.count' do
      password = 'password'
      post users_path,
           user: {name: 'TestUser',
                  email: 'test',
                  password: password,
                  password_confirmation: password},
           format: :json
      resultJSON = ActiveSupport::JSON.decode @response.body
      assert resultJSON["error"]
    end
  end

  test "valid signup information with account activation" do
    get signup_path

    assert_difference 'User.count', 1 do
      post users_path, user: { name:  "Example User",
                                email: "user@example.com",
                                password:              "password",
                                password_confirmation: "password" }
    end

    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?

    # 尝试在激活之前登录
    log_in_as(user)
    assert_not is_logged_in?

    # 激活令牌无效
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?

    # 令牌有效，电子邮件地址不对
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?

    # 激活令牌有效
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

end
