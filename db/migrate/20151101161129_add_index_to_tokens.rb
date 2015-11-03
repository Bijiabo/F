class AddIndexToTokens < ActiveRecord::Migration
  def change
    add_index :tokens, :token
  end
end
