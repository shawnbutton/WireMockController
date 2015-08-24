require_relative '../lib/wire_mock_caller'
require 'spec_helper'

describe 'WireMock Integration Tests - Require running WireMock instance', :integration do

  before :each do
    @sut = WireMockCaller.new
    @sut.reset_mappings
  end

  it 'should allow you to specify mapping and get it back' do

    body = 'this is the body that will be returned by the call to wiremock'
    get_method = 'GET'
    url = '/someurl'

    @sut.create_mapping(url, get_method, body)

    mappings = @sut.get_mappings

    first_mapping = mappings[0]

    request = first_mapping['request']
    expect(request['url']).to eq(url)
    expect(request['method']).to eq(get_method)

    response = first_mapping['response']
    expect(response['status']).to eq(200)
    expect(response['body']).to eq(body)

  end

  it 'should reset all mappings to default' do
    @sut.create_mapping("someurl", "GET", "some body")

    @sut.reset_mappings

    mappings = @sut.get_mappings

    default_mapping = '/api/json?pretty=true'
    expect(mappings[0]['request']['url']).to eq(default_mapping)

  end


end

