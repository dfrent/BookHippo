class AddGBooksIDtoBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :google_id, :string
  end
end
