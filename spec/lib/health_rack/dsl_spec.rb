require "spec_helper"

describe HealthRack::DSL do
  let(:config){ HealthRack::Configuration.new }

  describe "initializing without a block" do
    it "should not raise argument error" do
      expect{ HealthRack::DSL.new(config) }.not_to raise_error
    end
  end

  describe "initialize with a block that has one argument" do
    it "should call block passing itself as an argument" do
      expect{|b| HealthRack::DSL.new(config, &b) }.to yield_with_args(HealthRack::DSL)
    end
  end

  describe "initialize with a block that has no arguments" do
    it "should call the block in the context of itself"
  end

  describe "initialize with a block that has more than one argument" do
    it "should raise an error" do
      expect{ HealthRack::DSL.new(config){|a, b|} }.to raise_error(ArgumentError)
    end
  end

  describe "setting the title" do
    let(:dsl){ HealthRack::DSL.new(config) }

    it "should set the title on the config" do
      dsl.title "example"
      expect(config.title).to eq("example")
    end
  end

  describe "adding a check" do
    let(:dsl){ HealthRack::DSL.new(config) }

    it "should add a new check to the config" do
      dsl.check("Test"){ true }
      expect(config.checks.first).to be_kind_of(HealthRack::Check)
    end
  end
end
