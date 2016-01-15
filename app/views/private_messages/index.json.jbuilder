json.array!(@groups) do |group|
  json.user do
    json.extract! group[:user], :id, :name
    json.avatar group[:user][:avatar]
  end
  json.count group[:count]
  # json.url private_message_url(private_message, format: :json)
end
