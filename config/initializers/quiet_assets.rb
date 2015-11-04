class QuietAssets
  def initialize(app)
    @app = app
  end

  def call(env)
    original_level = Rails.logger.level
    if env['PATH_INFO'] =~ %r{\A/assets/}
      Rails.logger.level = Logger::WARN
    end
    @app.call(env)
  ensure
    Rails.logger.level = original_level
  end
end
