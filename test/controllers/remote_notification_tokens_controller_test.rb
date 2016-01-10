require 'test_helper'

class RemoteNotificationTokensControllerTest < ActionController::TestCase
  setup do
    @remote_notification_token = remote_notification_tokens(:one)
  end

  test "should create remote_notification_token" do
    assert_difference('RemoteNotificationToken.count') do
      post :create, remote_notification_token: { failed_count: @remote_notification_token.failed_count, token: @remote_notification_token.token, user_id: @remote_notification_token.user_id }
    end

    assert_redirected_to remote_notification_token_path(assigns(:remote_notification_token))
  end

  test "should destroy remote_notification_token" do
    assert_difference('RemoteNotificationToken.count', -1) do
      delete :destroy, id: @remote_notification_token
    end

    assert_redirected_to remote_notification_tokens_path
  end
end
