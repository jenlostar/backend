class HideRuntime
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    headers.delete('X-Runtime')
    [status, headers, body]
  end
end
