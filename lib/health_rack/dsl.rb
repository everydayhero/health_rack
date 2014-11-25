module HealthRack
  class DSL
    def initialize(config, &block)
      @config = config

      if block_given?
        case block.arity
        when 0 then instance_eval(&block)
        when 1, -1 then yield(self)
        else raise(ArgumentError, "wrong number of arguments 0..1")
        end
      end
    end

    def title(title)
      @config.title = title
    end

    def check(*args, &block)
      @config.checks << Check.new(*args, &block)
      nil
    end
  end
end
