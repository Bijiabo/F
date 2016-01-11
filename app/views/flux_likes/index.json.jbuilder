json.array!(@flux_likes) do |flux_like|
  json.extract! flux_like, :id, :user_id, :flux_id
  json.url flux_like_url(flux_like, format: :json)
end
