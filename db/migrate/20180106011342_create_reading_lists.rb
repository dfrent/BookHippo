class CreateReadingLists < ActiveRecord::Migration[5.1]
  def change
    create_table :reading_lists do |t|
      t.integer :user_id
      t.integer :book_id
      t.string :read_status
      t.datetime :date_completed

      t.timestamps
    end
  end
end
