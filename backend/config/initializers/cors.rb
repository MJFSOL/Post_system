Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5173' # change in production
    resource '*', headers: :any, methods: [:get, :post, :options], expose: ['Authorization']
  end
end