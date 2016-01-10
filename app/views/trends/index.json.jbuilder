json.array!(@trends) do |trend|
  json.extract! trend, :id, :content, :to_user_id, :from_user_id, :to_cat_id, :from_cat_id, :flux, :trends_type

  # from_user's data
  json.from_user do
    json.id trend.from_user.id
    json.name trend.from_user.name
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
