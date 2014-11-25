module HealthRack
  class Base
    class << self
      def title(title = @title)
        @title = title || "Health status"
      end

      def checks
        _checks.dup
      end

      def check(name, &block)
        _checks << Check.new(name, &block)
      end

      private

      def _checks
        @checks ||= []
      end
    end

    def call(env)
      Controller.new(env).perform(self)
    end

    def title
      self.class.title
    end

    def checks
      self.class.checks
    end

    def results
      checks.each(&:perform)
    end
  end
end
