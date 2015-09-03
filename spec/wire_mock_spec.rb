require 'spec_helper'
require 'wire_mock'
require_relative '../lib/wire_mock_caller'
require_relative '../lib/wire_mock_builder'

describe WireMock, :integration do

  it 'should be able to create a complicated mapping' do

    wire_mock_caller = WireMockCaller.new
    wire_mock_caller.reset_mappings

    wire_mock_builder = WireMockBuilder.new

    url = "/testurl"
    subject.given_that(
        wire_mock_builder.
            using_get.
            url_equal_to(url).
            then_return("body")
    )

    mappings = wire_mock_caller.get_mappings

    first_mapping = mappings[0]

    request = first_mapping['request']
    expect(request['url']).to eq(url)
    expect(request['method']).to eq("GET")

    response = first_mapping['response']
    expect(response['status']).to eq(200)
    expect(response['body']).to eq("body")


  end


end
