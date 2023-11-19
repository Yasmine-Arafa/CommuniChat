require 'sidekiq'
require 'sidekiq-scheduler'

# Sidekiq retrieves and processes these jobs from Redis
Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://localhost:6379/0' }
    
    Sidekiq.schedule = YAML.load_file(File.join(Rails.root, 'config', 'sidekiq_schedule.yml'))
    Sidekiq::Scheduler.reload_schedule!
end

# when Rails  (acting as a client)  enqueues jobs to Sidekiq
# ensuring that the client pushes jobs to the correct Redis instance
Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

Sidekiq::Scheduler.dynamic = true  # Allows editing the schedule on the fly (dynamic schedule)
