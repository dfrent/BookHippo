class CreateBookClubs < ActiveRecord::Migration[5.1]
  def change
    create_table :book_clubs do |t|
      t.string :name
      t.integer :book_id
      t.integer :user_id
      t.text :description
      t.text :goal

      t.timestamps
    end
  end
end
