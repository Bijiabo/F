json.user do
  json.id @user.id
  json.name @user.name
  json.following_count @user.following.count
  json.thumb_count @thumb_count
  json.cats do
    json.array!(@user.cats) do |cat|
      json.id cat.id
      json.name cat.name
    end
  end
  json.avatar letter_avatar_url_for(letter_avatar_for(username_for_avatar(@user.name), 200))
end

json.flux do
  json.array!(@fluxes) do |flux|
    json.extract! flux, :id, :motion, :content, :user_id, :like_count, :comment_count
    json.created_at format_date flux.created_at

    json.picture do
      json.array! flux.flux_images do |image|
        json.width image.width
        json.height image.height
        json.path image.picture.url
      end
    end

    json.url flux_url(flux, format: :json)
  end
end