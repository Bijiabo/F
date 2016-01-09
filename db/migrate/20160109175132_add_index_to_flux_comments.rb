class AddIndexToFluxComments < ActiveRecord::Migration
  def change
    add_index :flux_comments, :flux_id
  end
end
