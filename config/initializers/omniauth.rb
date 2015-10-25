OmniAuth.config.logger = Rails.logger
# environment variables can be defined in .env file.
FB_APP_ID = ENV['FB_APP_ID']
FB_APP_SECRET = ENV['FB_APP_SECRET']
G_APP_ID = ENV['GOOGLE_APP_ID']
G_APP_SECRET = ENV['GOOGLE_APP_SECRET']

if Rails.env.production?
  Rails.application.config.middleware.use OmniAuth::Builder do
    ## FACEBOOK
    provider :facebook, FB_APP_ID, FB_APP_SECRET,
             :scope => 'email', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}
    ## GOOGLE
    provider :google_oauth2, G_APP_ID, G_APP_SECRET,
             scope: 'email, profile', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google'
  end
else
  OmniAuth.config.full_host = 'http://local.twitter.com:3000'
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
          redirect_uri: 'http://local.twitter.com:3000/auth/google/callback'
        }
      end)
    }
  end

end


#OmniAuth.config.full_host = Rails.env.production? ? 'https://domain.com' : 'http://localhost:3000'
#{:scope => 'email', :client_options => {:ssl => {:ca_file => "#{Rails.root}/config/ca-bundle.crt"}}}
#{:scope => 'email', :display => 'popup', :client_options => {:ssl => {:ca_file => "C:/RailsInstaller/cacert.pem"}}}