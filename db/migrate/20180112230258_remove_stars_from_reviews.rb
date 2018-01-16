class RemoveStarsFromReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :stars
  end
end
