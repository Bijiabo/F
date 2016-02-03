json.array!(@groups) do |group|
  json.user do
    json.extract! group[:user], :id, :name
    json.avatar avatar_for_user group[:user]
  end
  json.count group[:count]
  json.latestMessage group[:latestMessage]
end
