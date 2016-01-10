class AddIndexToRemoteNotificationTokens < ActiveRecord::Migration
  def change
  end
  add_index :remote_notification_tokens, :token
end
