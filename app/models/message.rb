class Message < ApplicationRecord
    include Elasticsearch::Model    #  allowing the model to be indexed and queried using Elasticsearch
    include Elasticsearch::Model::Callbacks  # (hook) automatically update the index when a model is saved, updated or destroyed

    validates :number, uniqueness: { scope: :chat_id }

    belongs_to :chat, foreign_key: 'chat_id'

    index_name 'messages'

    # Define the settings and mappings for the Elasticsearch index
    settings index: { number_of_shards: 1 } do    # one shard is usually sufficient (Shards are essentially how Elasticsearch distributes data across the cluster)
        mappings dynamic: 'false' do    #Elasticsearch will not automatically add new fields to the index mapping
            indexes :body, type: 'text'  # adds this field to the index mapping
        end
    end


    # convert record to a JSON for indexing
    def as_indexed_json(options = {})
        as_json(only: [:body])  #  fields to index
    end


end
