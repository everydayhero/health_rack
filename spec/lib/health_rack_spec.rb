require "spec_helper"

describe HealthRack do
  describe "initializing" do
    let(:health_rack){ HealthRack.new }

    it "should return a new instance of the middleware" do
      expect(health_rack).to be_kind_of(HealthRack::Base)
    end
  end
end
