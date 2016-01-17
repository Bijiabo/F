json.array!(@users) do |user|
  json.id user.id
  json.name user.name
  json.avatar json.avatar letter_avatar_url_for(letter_avatar_for(username_for_avatar(user.name), 200))
  # json.extract! user, :id, :name
end