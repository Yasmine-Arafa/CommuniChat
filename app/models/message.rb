class Message < ApplicationRecord
    belongs_to :chat, foreign_key: 'chat_id'

    before_create :assign_number

    private

    def assign_number
        # self.number = chat.messages.maximum(:number).to_i + 1
        self.number = Chat.find(self.chat_id).messages.maximum(:number).to_i + 1
    end
end
