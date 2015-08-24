require_relative '../lib/wire_mock_caller'
require 'spec_helper'

describe 'WireMock Integration Tests - Require running WireMock instance', :integration do

  it 'should return mappings' do
    wiremock = WireMockCaller.new
    mappings = wiremock.get_mappings

    expect(mappings[0]['request']['url']).to eq('/testApi')
  end

  it 'should allow you to specify mapping' do
    body = 'this is the body that will be returned by the call to wiremock'

    wiremock = WireMockCaller.new
    wiremock.create_mapping('/someurl', 'GET', body)

    mappings = wiremock.get_mappings

    expect(mappings[0]['request']['url']).to eq('/someurl')
  end


end

