require_relative '../lib/wire_mock_caller'
require 'spec_helper'

describe 'WireMock Calls' do

  it 'should return mappings' do
    wiremock = WireMockCaller.new
    mappings = wiremock.get_mappings

    expect(mappings[0]['request']['url']).to eq('/api/json?pretty=true')
  end



end

