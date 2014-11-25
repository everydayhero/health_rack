require "spec_helper"

describe HealthRack::Renderers::HTMLRenderer do
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
    HealthRack::Renderers::HTMLRenderer.new(config).render(buffer)
  end

  describe "rendering" do
    it "should include the title in the header" do
      expect(buffer.to_s).to match(/<title>\s*Test\s*<\/title>/)
    end

    it "should include the title in the table caption" do
      expect(buffer.to_s).to match(/<caption>\s*Test\s*<\/caption>/)
    end

    it "should render checks" do
      expect(buffer.to_s).to match(/<tr>\s*<th>Foobar<\/th>\s*<td>OK<\/td>\s*<td>\d+\.\d+<\/td>\s*<\/tr>/i)
    end
  end
end
