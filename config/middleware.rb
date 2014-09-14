# load rb files from app/middlewares directory
# these are our custom middlewares
Dir[Rails.root.join('app/middlewares/*.rb')].each{|f| require f}

Rails.application.config.tap do |config|
  # disable unnecessary default middlewares
  config.middleware.delete ::Rack::Sendfile
  config.middleware.delete ::ActionDispatch::Static
  config.middleware.delete ::ActionDispatch::RequestId
  config.middleware.delete ::ActionDispatch::Cookies
  config.middleware.delete ::ActionDispatch::Session::CookieStore
  config.middleware.delete ::ActionDispatch::Flash
  config.middleware.delete ::ActionDispatch::Http::Headers
  config.middleware.delete ::Rack::ETag

  # remove headers: X-Frame-Options, X-XSS-Protection, X-Content-Type-Options
  config.action_dispatch.default_headers = {}

  # remove X-Runtime header
  config.middleware.insert_before(::Rack::Runtime, ::HideRuntime)
end
