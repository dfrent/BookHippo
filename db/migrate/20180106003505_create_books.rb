class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.datetime :release_date
      t.integer :average_rating
      t.integer :number_of_pages
      t.string :book_cover

      t.timestamps
    end
  end
end
