class AddColumnToFluxImages < ActiveRecord::Migration
  def change
    add_column :flux_images, :image, :string
  end
end
