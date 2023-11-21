class MessageCreationJob < ApplicationJob
  queue_as :default
  
  def perform(token, chat_number, message_params)
    application = Application.find_by(token: token)

    unless application
      Rails.logger.error "Application not found for token: #{token}"
      return
    end

    chat = Chat.find_by(number: chat_number, application_id: application.id)

    unless chat
      Rails.logger.error "Chat not found for number: #{chat_number}"
      return
    end

    message = chat.messages.create(message_params)

    if message.persisted?
      Rails.logger.info "Message created with number: #{message.number}"
    else
      Rails.logger.error "Failed to create message: #{message.errors.full_messages.join(', ')}"
    end

  end

end
