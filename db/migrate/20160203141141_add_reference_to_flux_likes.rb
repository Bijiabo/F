class AddReferenceToFluxLikes < ActiveRecord::Migration
  def change
    add_reference :flux_likes, :flux_comment
  end
end
