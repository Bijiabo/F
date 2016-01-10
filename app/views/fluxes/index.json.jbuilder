json.array!(@fluxes) do |flux|
  json.flux do
    json.extract! flux, :id, :motion, :content, :user_id, :created_at, :like_count, :comment_count
    json.picture flux.picture
  end

  if user = flux.user
    json.user do
      json.id user.id
      json.name user.name
    end
  end

  json.url flux_url(flux, format: :json)
end
