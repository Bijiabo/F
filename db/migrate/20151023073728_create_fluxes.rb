class CreateFluxes < ActiveRecord::Migration
  def change
    create_table :fluxes do |t|
      t.string :motion
      t.string :content
      t.string :user_id

      t.timestamps null: false
    end
  end
end
