json.array!(@fluxes) do |flux|
  json.extract! flux, :id, :motion, :content, :user_id
  json.url flux_url(flux, format: :json)
end
