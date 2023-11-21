class Chat < ApplicationRecord
    belongs_to :application, foreign_key: 'application_id'
    has_many :messages, dependent: :destroy

    before_create :assign_number

    private

    def assign_number      
      self.number = Application.find(self.application_id).chats.maximum(:number).to_i + 1    # fetchs the max field num. and increment by 1
    end
end