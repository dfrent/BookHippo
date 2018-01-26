class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.text :body
      t.references :book_club, index: true
      t.references :user, index: true
      t.boolean :read, :default => false

      t.timestamps
    end
  end
end
