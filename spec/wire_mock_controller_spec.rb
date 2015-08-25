require 'spec_helper'

describe WireMockController do
  it 'has a version number' do
    expect(WireMockController::VERSION).not_to be nil
  end


  it "should call wiremock for a default get request" do


    WireMockCaller.new


  end


end
