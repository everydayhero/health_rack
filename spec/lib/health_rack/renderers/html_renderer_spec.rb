require "spec_helper"

describe HealthRack::Renderers::HTMLRenderer do
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
    HealthRack::Renderers::HTMLRenderer.new(app).render(buffer)
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
