class AddColumnToFlux < ActiveRecord::Migration
  def change
    add_column :fluxes, :like_count, :integer, default: 0
    add_column :fluxes, :comment_count, :integer, default: 0
  end
end
