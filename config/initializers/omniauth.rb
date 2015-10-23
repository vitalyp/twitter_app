# environment variables can be defined in .env file.
APP_ID = ENV['FB_APP_ID']
APP_SECRET = ENV['FB_APP_SECRET']

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, APP_ID, APP_SECRET,
    {:scope => 'email', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}} 
end