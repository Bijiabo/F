class CreateFluxes < ActiveRecord::Migration
  def change
    create_table :fluxes do |t|
      t.string :motion
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :fluxes, [:user_id, :created_at]
  end
end
