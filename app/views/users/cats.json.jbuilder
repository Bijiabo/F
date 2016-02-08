json.array!(@user.cats) do |cat|
  json.extract! cat, :id, :name, :age, :breed, :latitude, :longitude, :gender
  json.avatar cat.avatar.url
end