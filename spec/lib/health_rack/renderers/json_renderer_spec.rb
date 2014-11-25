require "spec_helper"

describe HealthRack::Renderers::JSONRenderer do
  let(:app) do
    Class.new(HealthRack::Base) do
      title "Test"
      check("Foobar"){ true }
    end.new
  end
  let(:buffer) do
    Class.new(Array) do
      alias_method :write, :push

      def to_s
        join(" ")
      end
    end.new
  end

  before(:each) do
    HealthRack::Renderers::JSONRenderer.new(app).render(buffer)
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

