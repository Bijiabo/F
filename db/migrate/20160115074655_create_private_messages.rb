class CreatePrivateMessages < ActiveRecord::Migration
  def change
    create_table :private_messages do |t|
      t.references :toUser, index: true, foreign_key: true
      t.references :fromUser, index: true, foreign_key: true
      t.string :content
      t.string :picture

      t.timestamps null: false
    end
  end
end
