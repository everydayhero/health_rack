require "health_rack/version"

module HealthRack
  autoload :Configuration, "health_rack/configuration"
  autoload :DSL, "health_rack/dsl"
  autoload :Check, "health_rack/check"
  autoload :Controller, "health_rack/controller"
  autoload :Middleware, "health_rack/middleware"
  autoload :Renderers, "health_rack/renderers"

  def self.new(*args, &block)
    Middleware.new(*args, &block)
  end
end
