class RenamePrivateMessageColumn < ActiveRecord::Migration
  def change
    rename_column :private_messages, :toUser_id, :to_user_id
    rename_column :private_messages, :fromUser_id, :from_user_id
  end
end
