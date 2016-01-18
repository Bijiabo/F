json.comment @flux_comment

if @flux_comment.parentComment
  json.parent_comment do
    json.comment @flux_comment.parentComment
    json.user do
      json.id @flux_comment.parentComment.user.id
      json.name @flux_comment.parentComment.user.name
      json.avatar letter_avatar_url_for(letter_avatar_for(username_for_avatar(@flux_comment.parentComment.user.name), 200))
    end
  end
end

json.user do
  json.id @flux_comment.user_id
  json.name @flux_comment.user.name
  json.avatar letter_avatar_url_for(letter_avatar_for(username_for_avatar(@flux_comment.user.name), 200))
end

json.flux do
  json.id @flux_comment.flux.id
  json.content @flux_comment.flux.content
  json.comment_count @flux_comment.flux.comment_count
  json.created_at @flux_comment.flux.created_at

  json.user do
    json.id @flux_comment.flux.user.id
    json.name @flux_comment.flux.user.name
    json.avatar letter_avatar_url_for(letter_avatar_for(username_for_avatar(@flux_comment.flux.user.name), 200))
  end
end

json.set! "success", @success
