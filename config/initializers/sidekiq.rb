require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { size: Rails.env.staging? ? 12 : 15 }

end

Sidekiq::Extensions.enable_delay!
