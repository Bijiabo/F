class AddDeviceIdToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :deviceID, :string
  end
end
