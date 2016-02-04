class ChangeLocationPrecisionForCatLocation < ActiveRecord::Migration
  def change
    change_column :cats,  :latitude, :decimal, :precision => 18, :scale => 13
    change_column :cats,  :longitude, :decimal, :precision => 18, :scale => 13
  end
end
