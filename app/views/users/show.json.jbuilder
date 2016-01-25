json.user do
  json.id @user.id
  json.name @user.name
  json.following_count @user.following.count
  json.followers_count @user.followers.count
  json.thumb_count @thumb_count
  json.cats do
    json.array!(@user.cats) do |cat|
      json.id cat.id
      json.name cat.name
    end
  end
  json.avatar avatar_for_user @user
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