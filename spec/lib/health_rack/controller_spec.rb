require "spec_helper"

describe HealthRack::Controller do
  let(:config){ HealthRack::Configuration.new }

  describe "responding" do
    let(:controller){ HealthRack::Controller.new({}, config) }
    let(:response){ controller.perform }
    let(:headers){ response[1] }
    let(:body){ response[2].body.join }

    it "should return a rack-compatible response" do
      expect(response[0]).to be_kind_of(Fixnum)
      expect(response[1]).to be_kind_of(Hash)
      expect(response[2]).to respond_to(:each)
    end

    it "should set the content header" do
      expect(headers).to include("Content-type" => "text/html; charset=UTF-8")
    end

    it "should render to the body" do
      expect(body).not_to be_empty
    end
  end

  describe "the request's format when has an extension" do
    let(:env){ Hash.new }
    let(:controller){ HealthRack::Controller.new(env, config) }

    it "should return the extension" do
      env.update "PATH_INFO" => "/test.json"
      expect(controller.format).to eq('json')
    end

    it "should return the default extension when none specified" do
      env.update "PATH_INFO" => "/test"
      expect(controller.format).to eq('html')
    end

    it "should return the default extension when is invalid" do
      env.update "PATH_INFO" => "/test.json/"
      expect(controller.format).to eq('html')
    end
  end
end
