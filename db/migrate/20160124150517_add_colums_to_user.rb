class AddColumsToUser < ActiveRecord::Migration
  def change
    add_column :users, :gender, :integer, default: 0
    add_column :users, :province, :string, index: true
    add_column :users, :city, :string, index: true
    add_column :users, :introduction, :string
  end
end
