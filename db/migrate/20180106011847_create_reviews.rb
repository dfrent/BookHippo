class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :stars
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
