class DropUsersGenresJoinTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :genres_users
  end
end
