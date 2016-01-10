json.array!(@remote_notification_tokens) do |remote_notification_token|
  json.extract! remote_notification_token, :id, :token, :user_id, :failed_count
  json.url remote_notification_token_url(remote_notification_token, format: :json)
end
