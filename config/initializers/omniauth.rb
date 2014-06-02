OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '91567460252.apps.googleusercontent.com', 'tNP3BE7y53BLKTp0mtd-ZWqW',
           :client_options => {:ssl => {:ca_file => Rails.root.join('cacert.pem').to_s}},
           :prompt => 'select_account'
end
