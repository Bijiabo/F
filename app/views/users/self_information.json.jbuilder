json.extract! @user, :id, :email, :name, :gender, :activated, :province, :city, :introduction
json.following_count @user.following.count
json.followers_count @user.followers.count
json.thumb_count @thumb_count
json.avatar  avatar_for_user @user
json.success @success