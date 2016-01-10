class CreateRemoteNotificationTokens < ActiveRecord::Migration
  def change
    create_table :remote_notification_tokens do |t|
      t.string :token
      t.references :user, index: true, foreign_key: true
      t.integer :failed_count

      t.timestamps null: false
    end
  end
end
