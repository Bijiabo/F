json.array!(@users) do |user|
  json.id user.id
  json.name user.name
  json.avatar avatar_for_user user
  # json.extract! user, :id, :name
end