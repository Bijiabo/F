class CreateFluxLikes < ActiveRecord::Migration
  def change
    create_table :flux_likes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :flux, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
