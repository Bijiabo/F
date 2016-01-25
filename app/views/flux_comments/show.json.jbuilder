json.comment @flux_comment

if @flux_comment.parentComment
  json.parent_comment do
    json.comment @flux_comment.parentComment
    json.user do
      json.id @flux_comment.parentComment.user.id
      json.name @flux_comment.parentComment.user.name
      json.avatar avatar_for_user @flux_comment.parentComment.user
    end
  end
end

json.user do
  json.id @flux_comment.user_id
  json.name @flux_comment.user.name
  json.avatar avatar_for_user @flux_comment.user
end

json.flux do
  json.id @flux_comment.flux.id
  json.content @flux_comment.flux.content
  json.comment_count @flux_comment.flux.comment_count
  json.created_at @flux_comment.flux.created_at

  json.user do
    json.id @flux_comment.flux.user.id
    json.name @flux_comment.flux.user.name
    json.avatar avatar_for_user @flux_comment.flux.user
  end
end

json.set! "success", @success
