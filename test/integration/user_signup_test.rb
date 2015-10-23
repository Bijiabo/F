require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

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
    assert_template 'users/show'
    assert is_logged_in?
  end


end
