require_relative '../lib/wire_mock_caller'
require 'spec_helper'

describe 'WireMock Integration Tests - Require running WireMock instance', :integration do

  it 'should allow you to specify mapping and get it back' do
    body = 'this is the body that will be returned by the call to wiremock'

    wiremock = WireMockCaller.new

    wiremock.reset_mappings

    wiremock.create_mapping('/someurl', 'GET', body)

    mappings = wiremock.get_mappings

    first_mapping = mappings[0]

    request = first_mapping['request']
    expect(request['url']).to eq('/someurl')
    expect(request['method']).to eq('GET')

    response = first_mapping['response']
    expect(response['status']).to eq(200)
    expect(response['body']).to eq(body)

  end

  it 'should reset all mappings to default' do
    wiremock = WireMockCaller.new

    wiremock.reset_mappings

    mappings = wiremock.get_mappings

    expect(mappings[0]['request']['url']).to eq('/api/json?pretty=true')

  end


end

