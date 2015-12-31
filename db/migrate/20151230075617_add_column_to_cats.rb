class AddColumnToCats < ActiveRecord::Migration
  def change
    add_column :cats,  :latitude, :decimal, :precision => 15, :scale => 13
    add_column :cats,  :longitude, :decimal, :precision => 15, :scale => 13
  end
end