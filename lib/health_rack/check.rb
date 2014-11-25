require "benchmark"

module HealthRack
  class Check
    attr_reader :title, :value, :duration

    def initialize(title, &proc)
      @title = title || raise(ArgumentError, "A title must be specified")
      @proc = proc || raise(ArgumentError, "A block must be specified")
    end

    def perform
      measure
      value
    end

    def status
      case value
      when nil, 0, false, Exception then false
      else true
      end
    end

    alias_method :status?, :status

    def error?
      value.is_a? Exception
    end

    private

    def call
      @value = begin
        @proc.call
      rescue Exception => ex
        # Need to log the exception
        ex
      end
    end

    def measure
      @duration = Benchmark.realtime do
        call
      end
    end
  end
end
