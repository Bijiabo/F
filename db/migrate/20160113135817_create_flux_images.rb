class CreateFluxImages < ActiveRecord::Migration
  def change
    create_table :flux_images do |t|
      t.references :flux, index: true, foreign_key: true
      t.integer :width
      t.integer :height

      t.timestamps null: false
    end
  end
end
