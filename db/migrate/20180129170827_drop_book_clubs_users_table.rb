class DropBookClubsUsersTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :book_clubs_users
  end
end
