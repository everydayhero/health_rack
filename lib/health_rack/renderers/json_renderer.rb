require "json"

module HealthRack
  module Renderers
    class JSONRenderer
      CONTENT_TYPE = "application/json"

      def initialize(config)
        @config = config
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
          title: @config.title,
          status: overall_status,
          summary: summary
        }
      end

      def overall_status
        @config.checks.all?(&:status)
      end

      def summary
        @config.checks.map do |check|
          {title: check.title, status: check.status, duration: check.duration}
        end
      end
    end
  end
end
