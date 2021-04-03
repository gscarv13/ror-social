class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :sent_to, index: true
      t.boolean :status

      t.timestamps null: false
    end
    add_foreign_key :friendships, :users, column: :sent_to_id
  end
end
