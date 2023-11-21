namespace :elasticsearch do
    desc 'Index all Message records into Elasticsearch'
    task index_messages: :environment do
      puts 'Indexing messages...'
  
      Message.find_each(batch_size: 100) do |message|
        begin
          message.__elasticsearch__.index_document
          print '.'
        rescue => e
          puts "Error indexing message #{message.id}: #{e.message}"
        end
      end
  
      puts 'Indexing completed.'
    end
  end
  