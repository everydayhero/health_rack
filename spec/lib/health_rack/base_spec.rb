require "spec_helper"

describe HealthRack::Base do
  describe "default" do
    let(:base){ HealthRack::Base }

    it "should have 'Health status' as the title" do
      expect(base.title).to eq("Health status")
    end

    it "should have checks be an empty array" do
      expect(base.checks).to eq([])
    end
  end

  describe "configuration" do
    let(:base) do
      Class.new(HealthRack::Base) do
        title "Test"

        check "Foobar" do
          true
        end
      end
    end

    it "should set the title" do
      expect(base.title).to eq("Test")
    end

    it "should add a check" do
      expect(base.checks).not_to be_empty
    end
  end

  describe "calling" do
    let(:app){ HealthRack::Base.new }
    let(:result){ app.call(Hash.new) }

    it "should include a status code" do
      expect(result[0]).to be_kind_of(Fixnum)
    end

    it "should include headers" do
      expect(result[1]).to be_kind_of(Hash)
    end

    it "should return an object that responds to each" do
      expect(result[2]).to respond_to(:each)
    end
  end

  describe "accessors" do
    let(:app){ HealthRack::Base.new }

    it "should return the title set on the class" do
      expect(app.title).to eq(HealthRack::Base.title)
    end

    it "should return the checks set on the class" do
      expect(app.checks).to eq(HealthRack::Base.checks)
    end
  end
end
