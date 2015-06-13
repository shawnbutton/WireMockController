require_relative '../lib/wire_mock_caller'
require 'spec_helper'

describe 'WireMock Calls' do

  it 'should return mappings' do
    wiremock = WireMockCaller.new
    mappings = wiremock.get_mappings

    expect(mappings[0]['request']['url']).to eq('/testApi')
  end


  it 'should all you to specify mapping' do
    body = 'this is the body that will be returned by the call to wiremock'

    wiremock = WireMockCaller.new
    wiremock.create_mapping('/someurl', 'GET', body)

    mappings = wiremock.get_mappings

    expect(mappings[0]['request']['url']).to eq('/something')
  end


end

