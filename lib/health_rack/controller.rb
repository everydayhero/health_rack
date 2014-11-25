require "rack/request"
require "rack/response"
require "rack/body_proxy"

module HealthRack
  class Controller
    def initialize(env, config)
      @config = config
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def perform
      @response['Content-type'] = renderer.content_type
      renderer.render(@response)
      @response.finish
    end

    def format
      @format ||= begin
        md = @request.path_info.match(/\.([a-z]+)$/i) || []
        md[1] || 'html'
      end
    end

    private

    def renderer
      @renderer ||= Renderers.find(format).new(@config)
    end
  end
end
