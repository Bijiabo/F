json.users do
  json.array!(@users) do |user|
    json.extract! user[:info], :id, :name
    json.avatar avatar_for_user user[:info]
    json.name_spelling user[:name_spelling]
  end
end

json.success @success