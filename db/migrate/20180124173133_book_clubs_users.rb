class BookClubsUsers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :book_clubs, :users do |t|
      t.index :book_club_id
      t.index :user_id
    end
  end
end
