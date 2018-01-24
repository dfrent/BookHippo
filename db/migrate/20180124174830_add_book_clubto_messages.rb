class AddBookClubtoMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :book_club_id, :integer
  end
end
