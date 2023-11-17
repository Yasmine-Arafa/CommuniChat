class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.integer :chat_id
      t.integer :number
      t.text :body

      t.timestamps
    end
  end
end
