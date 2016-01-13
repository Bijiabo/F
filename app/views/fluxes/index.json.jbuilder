json.array!(@fluxes) do |flux|
  json.flux do
    json.extract! flux, :id, :motion, :content, :user_id, :like_count, :comment_count
    json.created_at format_date flux.created_at

    json.picture do
      json.array! flux.flux_images, :width, :height, :picture
    end
  end

  if user = flux.user
    json.user do
      json.id user.id
      json.name user.name
    end
  end

  json.url flux_url(flux, format: :json)
end
