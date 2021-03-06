require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AlkimiiMailer
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # config.action_mailer.delivery_method = :mailgun
    # config.action_mailer.mailgun_settings = {
    #   api_key: '',
    #   domain: '',
    # }
  end
end
