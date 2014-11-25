require "spec_helper"

describe HealthRack::Check do
  describe "initialization" do
    it "should raise an error when no title is given" do
      expect{ HealthRack::Check.new(nil) }.to raise_error(ArgumentError)
    end

    it "should raise an error when no block is given" do
      expect{ HealthRack::Check.new("test") }.to raise_error(ArgumentError)
    end
  end

  {"an object" => Object.new, "a one" => 1, "true" => true}.each do |desc, value|
    describe "performing a successful check returning #{desc}" do
      let(:check){ HealthRack::Check.new("test"){ value } }

      before(:each) do
        check.perform
      end

      it "should set value to the return value of proc" do
        expect(check.value).to eq(value)
      end

      it "should measure the duration of the check" do
        expect(check.duration).not_to be_nil
      end

      it "should mark the status true" do
        expect(check.status).to be(true)
      end
    end
  end

  {"nil" => nil, "zero" => 0, "false" => false}.each do |desc, value|
    describe "performing a failed check returning #{desc}" do
      let(:check){ HealthRack::Check.new("test"){ value } }

      before(:each) do
        check.perform
      end

      it "should set value to the return value of proc" do
        expect(check.value).to eq(value)
      end

      it "should measure the duration of the check" do
        expect(check.duration).not_to be_nil
      end

      it "should mark the status false" do
        expect(check.status).to be(false)
      end
    end
  end

  describe "performing a check that raises an error" do
    let(:error){ Exception.new("oi") }
    let(:check){ HealthRack::Check.new("test"){ raise error } }

    before(:each) do
      check.perform
    end

    it "should set the value to the exception" do
      expect(check.value).to be(error)
    end

    it "should measure the duration of the check" do
      expect(check.duration).not_to be_nil
    end

    it "should mark the status false" do
      expect(check.status).to be(false)
    end
  end
end
