json.success @success
json.user do
  json.extract! @user, :id, :name, :admin, :activated, :gender, :province, :city, :introduction
  json.avatar avatar_for_user @user

  json.following_count @user.following.count
  json.followers_count @user.followers.count
  json.thumb_count @thumb_count

  json.following current_user.following.include? @user

end