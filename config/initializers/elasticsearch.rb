Elasticsearch::Model.client = Elasticsearch::Client.new(host: 'elasticsearch:9200')
Elasticsearch::Model.client.cluster.health
