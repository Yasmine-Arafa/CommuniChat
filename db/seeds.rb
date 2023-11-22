require 'faker'


# db/seeds.rb
5.times do
    application = Application.create(name: Faker::App.name)
    2.times do
      chat = Chat.create(application_id: application.id)
      3.times do
        Message.create(chat_id: chat.id, body: Faker::Lorem.sentence)
      end
    end
  end

  puts "Seed data generated successfully!"
