json.flux do
  json.extract! @flux, :id, :motion, :content, :user_id, :created_at, :updated_at, :like_count, :comment_count
end

json.user do
  json.id @flux.user.id
  json.name @flux.user.name
  json.avatar letter_avatar_url_for(letter_avatar_for(username_for_avatar(@flux.user.name), 200))
end