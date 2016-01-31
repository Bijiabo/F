class AddGenderToCat < ActiveRecord::Migration
  def change
    add_column :cats, :gender, :integer, default: 1
  end
end
