class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.integer :book_club_id
      t.integer :user_id

      t.timestamps
    end
  end
end
