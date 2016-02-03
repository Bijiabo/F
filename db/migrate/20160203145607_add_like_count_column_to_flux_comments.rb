class AddLikeCountColumnToFluxComments < ActiveRecord::Migration
  def change
    add_column :flux_comments, :like_count, :integer, default: 0
  end
end
