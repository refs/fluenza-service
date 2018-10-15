# -*- encoding : utf-8 -*-
require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { :size => 2 }
end

Sidekiq.configure_server do |config|
  config.redis = { :size => 30 }
end
