VkontakteApi.configure do |config|
  config.app_id     = ENV['VK_APP_ID']
  config.app_secret = ENV['VK_APP_SECRET']

  config.logger        = Rails.logger
  config.log_requests  = true
  config.log_errors    = true
  config.log_responses = !Rails.env.production?
end
VkontakteApi.register_alias
