class ChatCreationJob < ApplicationJob
  queue_as :default

  def perform(token)
    application = Application.find_by(token: token)

    unless application
      Rails.logger.error "Application not found for token: #{token}"
      return
    end

    chat = application.chats.create

    if chat.persisted?
      Rails.logger.info "Chat created with number: #{chat.number}"
    else
      Rails.logger.error "Failed to create chat: #{chat.errors.full_messages.join(', ')}"
    end

  end

end
