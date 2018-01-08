class RemoveBookAndUserId < ActiveRecord::Migration[5.1]
  def change
    remove_column :genres, :book_id
    remove_column :genres, :user_id
  end
end
