class Chat < ApplicationRecord
    belongs_to :application, foreign_key: 'application_id'
    has_many :messages, dependent: :destroy

    validates :number, uniqueness: { scope: :application_id }


end