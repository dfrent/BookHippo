class IsbNintegerToString < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :isbn, :string
  end
end
