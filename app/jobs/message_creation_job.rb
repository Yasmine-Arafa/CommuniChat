class MessageCreationJob < ApplicationJob
  queue_as :default
  
  def perform(token, chat_number, message_number, message_params, retry_count = 0)

    application = Application.find_by(token: token)

    chat = Chat.find_by(number: chat_number, application_id: application.id)

    begin

      message = chat.messages.create!( number: message_number, body: message_params[:body])
      

      if message.persisted?
        Rails.logger.info "Message created with number: #{message.number}"
      else
        Rails.logger.error "Failed to create message: #{message.errors.full_messages.join(', ')}"
      end

    rescue ActiveRecord::RecordNotUnique    # if a race condition happens

      if retry_count < 3

        Rails.logger.error "Message number conflict for chat: #{chat_number}"

        new_number = chat.messages.maximum(:number).to_i + 1    # retry another number

        MessageCreationJob.perform_later(
            token,
            new_number,
            message_params,
            retry_count + 1
          )
        
      else
        Rails.logger.error "Max retry limit reached for Message creation."
      end


    end







  end

end


  
  

