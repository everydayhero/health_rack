module HealthRack
  module Renderers
    class HTMLRenderer
      CONTENT_TYPE = "text/html; charset=UTF-8"

      def initialize(config)
        @config = config
      end

      def content_type
        CONTENT_TYPE
      end

      def render(buffer)
        buffer.write <<-HTML
        <doctype html>
        <html>
          <head>
            <meta charset="utf-8">
            <title>#{@config.title}</title>
          </head>
          <body>
            <table border="1">
              <caption>#{@config.title}</caption>
              <thead>
                <tr>
                  <th>&nbsp;</th>
                  <th>Status</th>
                  <th>Time</th>
                </tr>
              </thead>
              <tbody>
        HTML

        @config.checks.each do |check|
          buffer.write <<-HTML
          <tr>
            <th>#{check.title}</th>
            <td>#{status(check)}</td>
            <td>#{check.duration.to_f * 1000}</td>
          </tr>
          HTML
        end

        buffer.write <<-HTML
              </tbody>
            </table>
          </body>
        </html>
        HTML
      end

      private

      def status(check)
        case
          when check.error? then 'ERROR'
          when check.status? then 'OK'
          else 'FAIL'
        end
      end
    end
  end
end
