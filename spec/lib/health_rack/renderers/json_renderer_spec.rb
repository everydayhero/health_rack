require "spec_helper"

describe HealthRack::Renderers::JSONRenderer do
  class Buffer < Array
    alias_method :write, :push

    def to_s
      join(" ")
    end
  end

  let(:check){ HealthRack::Check.new("Foobar"){ true } }
  let(:config){ HealthRack::Configuration.new(title: "Test") }
  let(:buffer){ Buffer.new }

  before(:each) do
    check.perform
    config.checks << check
    HealthRack::Renderers::JSONRenderer.new(config).render(buffer)
  end

  describe "rendering" do
    it "should include the title" do
      expect(buffer.to_s).to match(/"title":\s*"Test"/)
    end

    it "should include the overall status" do
      expect(buffer.to_s).to match(/"status":\s*true/)
    end

    it "should render checks" do
      expect(buffer.to_s).to match(/{\s*"title":\s*"Foobar",\s*"status":\s*true,\s*"duration":\s*\d+/)
    end
  end
end

