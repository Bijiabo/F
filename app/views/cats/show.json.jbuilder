json.extract! @cat, :id, :name, :age, :breed, :gender, :latitude, :longitude
json.avatar avatar_for_user @cat

json.user do
  json.extract! @cat.user, :id, :name
  json.avatar avatar_for_user @cat.user
end