class ChangeStarsValueField < ActiveRecord::Migration[5.1]
  def change
    change_column :ratings, :stars, :float
  end
end
