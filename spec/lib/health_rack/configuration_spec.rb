require "spec_helper"

describe HealthRack::Configuration do
  describe "initializing with no arguments" do
    let(:config){ HealthRack::Configuration.new }

    it "should default title to nil" do
      expect(config.title).to be_nil
    end

    it "should default path to nil" do
      expect(config.path).to be_nil
    end

    it "should default checks to an empty array" do
      expect(config.checks).to eq([])
    end
  end

  describe "initializing with options" do
    let(:options){ {title: "Test", path: "/test", checks: [:foo]} }
    let(:config){ HealthRack::Configuration.new(options) }

    it "should set title" do
      expect(config.title).to eq("Test")
    end

    it "should set path" do
      expect(config.path).to eq("/test")
    end

    it "shouldn't set checks" do
      expect(config.checks).to eq([])
    end
  end
end
