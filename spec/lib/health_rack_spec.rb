require "spec_helper"

describe HealthRack do
  describe "initializing" do
    let(:app){ lambda{} }
    let(:health_rack){ HealthRack.new(app) }

    it "should return a new instance of the middleware" do
      expect(health_rack).to be_kind_of(HealthRack::Middleware)
    end
  end
end
