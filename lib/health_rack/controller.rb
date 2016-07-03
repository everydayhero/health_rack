require "rack"
require "rack/request"
require "rack/response"
require "rack/body_proxy"

module HealthRack
  class Controller
    def initialize(env)
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def perform(app)
      renderer = renderer_class.new(app)

      renderer.render(@response)

      @response['Content-type'] = renderer.content_type
      @response.finish
    end

    def format
      @format ||= begin
        md = @request.path_info.match(/\.([a-z]+)$/i) || []
        md[1] || 'html'
      end
    end

    private

    def renderer_class
      @renderer_class ||= Renderers.find(format)
    end
  end
end
