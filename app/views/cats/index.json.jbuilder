json.array!(@cats) do |cat|
  json.extract! cat, :id, :name, :age, :breed, :user_id, :latitude, :longitude, :gender
  json.avatar cat.avatar.url
end

