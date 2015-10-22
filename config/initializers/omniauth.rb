APP_ID = '937758376302379'
APP_SECRET = '69b294eb1384fbf73c4d8f8f5d9448bf'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, APP_ID, APP_SECRET
end