json.array!(@fluxes) do |flux|
  json.flux do
    json.extract! flux, :id, :motion, :content, :user_id, :like_count, :comment_count
    json.created_at format_date flux.created_at

    json.picture do
      json.array! flux.flux_images do |image|
        json.width image.width
        json.height image.height
        json.path image.picture.url
      end
    end

    json.like @flux_likes.include?(flux.id)
  end

  if user = flux.user
    json.user do
      json.id user.id
      json.name user.name
      json.avatar avatar_for_user user
      json.following @following.include? user.id
    end
  end

  json.cats do
    json.array!(flux.user.cats) do |cat|
      json.name cat.name
      json.age cat.age
    end
  end

  json.url flux_url(flux, format: :json)
end
