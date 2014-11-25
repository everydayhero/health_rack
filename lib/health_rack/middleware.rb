module HealthRack
  class Middleware
    DEFAULT_OPTIONS = {
      title: "Health check",
      path: "/health",
    }.freeze

    def initialize(app, options = {}, &block)
      @app = app
      @config = Configuration.new(DEFAULT_OPTIONS.merge(options))

      DSL.new(@config, &block) if block_given?
    end

    def call(env)
      if @config.path.start_with?(env['PATH_INFO'])
        Controller.new(env, @config).perform
      else
        @app.call(env)
      end
    end
  end
end
