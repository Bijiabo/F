class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.text :content
      t.references :to_user, index: true, foreign_key: true
      t.references :from_user, index: true, foreign_key: true
      t.references :to_cat, index: true, foreign_key: true
      t.references :from_cat, index: true, foreign_key: true
      t.references :flux, index: true, foreign_key: true
      t.string :type, index: true
      t.boolean :read, index: true, default: false

      t.timestamps null: false
    end
  end
end
