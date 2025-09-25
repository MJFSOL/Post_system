Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5173' # frontend URL

    resource '*',
      headers: :any,
      methods: [:get, :post, :options, :put, :patch, :delete],
      expose: ['Authorization'],
      credentials: true
  end
end
