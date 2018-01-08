class AddTableGenresUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :genres_users, :id => false do |t|
      t.integer :genre_id
      t.integer :user_id
    end
  end
end
