json.flux do
  json.extract! @flux, :id, :motion, :content, :user_id, :like_count, :comment_count
  json.created_at format_date @flux.created_at

  json.picture do
    json.array! @flux.flux_images do |image|
      json.width image.width
      json.height image.height
      json.path image.picture.url
    end
  end
end

json.user do
  json.id @flux.user.id
  json.name @flux.user.name
  json.avatar avatar_for_user @flux.user
  json.following @is_following
end