class AddColumnsToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :description, :text
    add_column :books, :small_thumbnail, :string
  end
end
