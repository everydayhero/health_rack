require "health_rack/version"

module HealthRack
  autoload :Base, "health_rack/base"
  autoload :Check, "health_rack/check"
  autoload :Controller, "health_rack/controller"
  autoload :Renderers, "health_rack/renderers"

  def self.new(*args, &block)
    Base.new(*args, &block)
  end
end
