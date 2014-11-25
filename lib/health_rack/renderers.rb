module HealthRack
  module Renderers
    autoload :HTMLRenderer, "health_rack/renderers/html_renderer"
    autoload :JSONRenderer, "health_rack/renderers/json_renderer"

    def self.find(name)
      const_get "#{name.to_s.upcase}Renderer"
    end
  end
end
