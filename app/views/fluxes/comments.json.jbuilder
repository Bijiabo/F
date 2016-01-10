json.array!(@comments) do |comment|
  # comment data
  json.comment comment
  # comment's user data
  if user = comment.user
    json.user do
      json.id user.id
      json.name user.name
    end
  end

end