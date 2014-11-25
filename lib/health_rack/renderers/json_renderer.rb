require "json"

module HealthRack
  module Renderers
    class JSONRenderer
      CONTENT_TYPE = "application/json"

      def initialize(app)
        @app = app
      end

      def content_type
        CONTENT_TYPE
      end

      def render(buffer)
        buffer.write(json)
      end

      private

      def json
        JSON.generate(data)
      end

      def data
        {
          title: @app.title,
          status: overall_status,
          summary: summary
        }
      end

      def overall_status
        results.all?(&:status)
      end

      def summary
        results.map do |result|
          {title: result.title, status: result.status, duration: result.duration}
        end
      end

      def results
        @results ||= @app.results
      end
    end
  end
end
