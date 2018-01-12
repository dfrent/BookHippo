class AddingDateTimeToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :date_added, :datetime
  end
end
