class AddPicturesToFluxes < ActiveRecord::Migration
  def change
    add_column :fluxes, :picture, :string
  end
end
