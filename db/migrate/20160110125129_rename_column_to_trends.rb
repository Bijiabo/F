class RenameColumnToTrends < ActiveRecord::Migration
  def change
    rename_column :trends, :type, :trends_type
  end
end
