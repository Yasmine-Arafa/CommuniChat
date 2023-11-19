class CountUpdateJob
    include Sidekiq::Worker
  
    def perform
        # Update chats_count for each application
        Application.find_each do |application|
            application.update(chats_count: application.chats.count)
        end
    
        # Update messages_count for each chat
        Chat.find_each do |chat|
            chat.update(messages_count: chat.messages.count)
        end
    end
  end
