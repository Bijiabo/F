class RenameColumnToFluxImage < ActiveRecord::Migration
  def change
    rename_column :flux_images, :image, :picture
  end
end
