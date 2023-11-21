class AddUniqueIndexToChats < ActiveRecord::Migration[7.1]
  def change
    add_index :chats, [:application_id, :number], unique: true
  end
end
