class CreateFluxComments < ActiveRecord::Migration
  def change
    create_table :flux_comments do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :flux_comments, [:user_id]
  end
end
