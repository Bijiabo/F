class AddAvatarToCat < ActiveRecord::Migration
  def change
    add_column :cats, :avatar, :string
  end
end
