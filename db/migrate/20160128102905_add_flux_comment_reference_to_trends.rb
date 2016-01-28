class AddFluxCommentReferenceToTrends < ActiveRecord::Migration
  def change
    add_reference :trends, :flux_comment
  end
end
