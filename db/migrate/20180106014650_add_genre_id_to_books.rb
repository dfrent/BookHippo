class AddGenreIdToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :genre_id, :integer
  end
end
