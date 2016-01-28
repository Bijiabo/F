json.array!(@trends) do |trend|
  json.extract! trend, :id, :content, :to_user_id, :from_user_id, :to_cat_id, :from_cat_id, :trends_type
  json.created_at format_date trend.created_at

  if trend.flux
    json.flux do
      json.extract! trend.flux, :id, :motion, :content, :user_id, :like_count, :comment_count
      json.picture do
        json.array! trend.flux.flux_images do |image|
          json.width image.width
          json.height image.height
          json.path image.picture.url
        end
      end
    end
  end

  json.flux_comment trend.flux_comment

  # from_user's data
  json.from_user do
    json.id trend.from_user.id
    json.name trend.from_user.name
    json.avatar avatar_for_user trend.from_user
  end

  # target data url
  case trend.trends_type
    # flux
    when TrendsHelper::Type::FLUX_REFER
      json.url flux_url(trend.flux, format: :json)
    when TrendsHelper::Type::FLUX_LIKE
      json.url flux_url(trend.flux, format: :json)
    when TrendsHelper::Type::FLUX_COMMENT_REFER
      json.url flux_url(trend.flux, format: :json)
    when TrendsHelper::Type::FLUX_COMMENT_REPLY
      json.url flux_url(trend.flux, format: :json)
    when TrendsHelper::Type::FLUX_COMMENT_THUMBS

    # relationship
    when TrendsHelper::Type::FOLLOW
      json.url user_url(trend.from_user, format: :json)
  end

end
