# config/initializers/devise.rb
Devise.setup do |config|
  config.mailer_sender = 'please-change-me@example.com'
  require 'devise/orm/active_record'

  # JWT setup
  config.jwt do |jwt|
    jwt.secret = ENV['DEVISE_JWT_SECRET_KEY'] || Rails.application.credentials.devise_jwt_secret_key
    jwt.dispatch_requests = [
      ['POST', %r{^/login$}],
      ['POST', %r{^/graphql$}] # Add this line to handle GraphQL login requests
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/logout$}]
    ]
    jwt.request_formats = { user: [:json] }
  end
end