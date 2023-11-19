# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'


# db/seeds.rb
10.times do
    application = Application.create(name: Faker::App.name)
    6.times do
      chat = Chat.create(application_id: application.id)
      7.times do
        Message.create(chat_id: chat.id, body: Faker::Lorem.sentence)
      end
    end
  end

  puts "Seed data generated successfully!"
