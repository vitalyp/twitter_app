OmniAuth.config.logger = Rails.logger
# environment variables can be defined in .env file.
FB_APP_ID = ENV['FB_APP_ID']
FB_APP_SECRET = ENV['FB_APP_SECRET']
G_APP_ID = ENV['GOOGLE_APP_ID']
G_APP_SECRET = ENV['GOOGLE_APP_SECRET']

if Rails.env.production?
  GOOGLE_REDIRECT_URL = ENV['GOOGLE_REDIRECT_URL'] || 'https://vitalyp-twitter-app.herokuapp.com/auth/google/callback'
else
  GOOGLE_REDIRECT_URL = 'http://local.twitter.com:3000/auth/google/callback'
  OmniAuth.config.full_host = 'http://local.twitter.com:3000'
end

if Rails.env.production?
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, FB_APP_ID, FB_APP_SECRET,
             :scope => 'email', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}
    provider :google_oauth2, G_APP_ID, G_APP_SECRET, {
      name: 'google',
      skip_jwt: true,
      scope: 'email, profile',
      prompt: 'select_account',
      image_aspect_ratio: 'square',
      image_size: 50,
      setup: (lambda do |env|
       request = Rack::Request.new(env)
       env['omniauth.strategy'].options['token_params'] = {
           redirect_uri: GOOGLE_REDIRECT_URL
       }
      end)
    }
  end
else

  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, FB_APP_ID, FB_APP_SECRET,
             :scope => 'email', :client_options => {:ssl => {:ca_file => "#{Rails.root}/config/ca-bundle.crt"}}
    provider :google_oauth2, G_APP_ID, G_APP_SECRET, {
      name: 'google',
      skip_jwt: true,
      scope: 'email, profile',
      prompt: 'select_account',
      image_aspect_ratio: 'square',
      image_size: 50,
      setup: (lambda do |env|
       request = Rack::Request.new(env)
       env['omniauth.strategy'].options['token_params'] = {
           redirect_uri: GOOGLE_REDIRECT_URL
       }
      end)
    }
  end
end
