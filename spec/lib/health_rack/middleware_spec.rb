require "spec_helper"

describe HealthRack::Middleware do
  describe "initialization" do
    let(:app){ lambda{|env|} }

    it "should call block when block is given" do
      expect{|b| HealthRack::Middleware.new(app, {}, &b) }.to yield_control
    end
  end

  describe "calling the middleware" do
    let(:env){ {"PATH_INFO" => "/test"} }

    it "should respond when path info matches the path" do
      expect do |block|
        HealthRack::Middleware.new(Proc.new(&block), {path: "/test"}).call(env)
      end.not_to yield_with_args(env)
    end

    it "should respond when path info matches the path with the format" do
      expect do |block|
        HealthRack::Middleware.new(Proc.new(&block), {path: "/test.html"}).call(env)
      end.not_to yield_with_args(env)
    end

    it "should call the app when path info doesn't match the path" do
      expect do |block|
        HealthRack::Middleware.new(Proc.new(&block), {}).call(env)
      end.to yield_with_args(env)
    end
  end
end
