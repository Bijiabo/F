json.array!(@comments) do |comment|
  # comment data
  json.comment do
    json.id comment.id
    json.content comment.content
    json.created_at format_date comment.created_at
  end

  if comment.parentComment
    json.parent_comment do
      json.comment comment.parentComment
      json.user do
        json.id comment.parentComment.user.id
        json.name comment.parentComment.user.name
        json.avatar avatar_for_user comment.parentComment.user
      end
    end
  end

  # comment's user data
  json.user do
    json.id comment.user.id
    json.name comment.user.name
    json.avatar avatar_for_user comment.user
  end

end