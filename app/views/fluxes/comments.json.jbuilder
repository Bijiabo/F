json.array!(@comments) do |comment|
  # comment data
  json.comment comment

  json.parent_comment comment.parentComment

  # comment's user data
  json.user do
    json.id comment.user.id
    json.name comment.user.name
  end

end