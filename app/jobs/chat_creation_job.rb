class ChatCreationJob < ApplicationJob
  queue_as :default

  def perform(token, number, retry_count = 0)
 
    application = Application.find_by(token: token)

    begin
      
      chat = application.chats.create!(number: number)  # '!' to raise an exception if the record is invalid (ActiveRecord::RecordNotUnique)
      
      if chat.persisted?
        Rails.logger.info "Chat created with number: #{chat.number}"
      else
        Rails.logger.error "Failed to create chat: #{chat.errors.full_messages.join(', ')}"
      end

    rescue ActiveRecord::RecordNotUnique    # if a race condition happens

      if retry_count < 3

        Rails.logger.error "Chat number conflict for application: #{application.id}"

        new_number = application.chats.maximum(:number).to_i + 1      # retry another number

        ChatCreationJob.perform_later(token, new_number, retry_count + 1)

      else
        Rails.logger.error "Max retry limit reached for chat creation."
      end

    end

  end

end


