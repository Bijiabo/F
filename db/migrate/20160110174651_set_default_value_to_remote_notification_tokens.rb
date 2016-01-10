class SetDefaultValueToRemoteNotificationTokens < ActiveRecord::Migration
  def change
    change_column_default :remote_notification_tokens, :failed_count, 0
  end
end
