class AddPublishedInfoToBooks < ActiveRecord::Migration[5.1]
  def change
    rename_column :books, :release_date, :published_date
    add_column :books, :publisher, :string
  end
end
