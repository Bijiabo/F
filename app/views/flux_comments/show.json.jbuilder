json.comment @flux_comment

json.user do
  json.id @flux_comment.user_id
  json.name @flux_comment.user.name
end

json.flux do
  json.id @flux_comment.flux.id
  json.content @flux_comment.flux.content
  json.comment_count @flux_comment.flux.comment_count
  json.created_at @flux_comment.flux.created_at

  json.user do
    json.id @flux_comment.flux.user.id
    json.name @flux_comment.flux.user.name
  end
end

json.set! "success", @success
