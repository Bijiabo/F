json.array!(@users) do |user|
  json.extract! user, :id, :name
  # json.relationshipID: :user
end