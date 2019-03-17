class CreateRejectedIsbns < ActiveRecord::Migration[5.1]
  def change
    create_table :rejected_isbns do |t|
      t.string :isbn

      t.timestamps
    end
  end
end
