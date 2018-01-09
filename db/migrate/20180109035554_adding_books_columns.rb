class AddingBooksColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :number_of_pages
    add_column :books, :isbn, :integer
    add_column :books, :page_count, :integer
    add_column :books, :country_of_origin, :string
  end
end
