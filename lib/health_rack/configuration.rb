module HealthRack
  class Configuration
    attr_accessor :title, :path
    attr_reader :checks

    def initialize(options = {})
      @checks = []

      options.each do |name, value|
        method_name = "#{name}="
        public_send(method_name, value) if respond_to?(method_name, false)
      end
    end
  end
end

