class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :token, unique: true
      t.string :name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
