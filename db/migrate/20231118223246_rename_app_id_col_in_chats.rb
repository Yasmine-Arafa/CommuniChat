class RenameAppIdColInChats < ActiveRecord::Migration[7.1]
  def change
    rename_column :chats, :app_id, :application_id
  end
end
