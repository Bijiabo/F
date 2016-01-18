json.array!(@comments) do |comment|
  # comment data
  json.comment comment

  if comment.parentComment
    json.parent_comment do
      json.comment comment.parentComment
      json.user do
        json.id comment.parentComment.user.id
        json.name comment.parentComment.user.name
        json.avatar letter_avatar_url_for(letter_avatar_for(username_for_avatar(comment.parentComment.user.name), 200))
      end
    end
  end

  # comment's user data
  json.user do
    json.id comment.user.id
    json.name comment.user.name
    json.avatar letter_avatar_url_for(letter_avatar_for(username_for_avatar(comment.user.name), 200))
  end

end