json.extract! @user, :id, :email, :name, :activated
json.avatar @user.avatar.url
json.success @success