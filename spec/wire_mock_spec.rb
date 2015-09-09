require 'spec_helper'
require 'wire_mock'
require_relative '../lib/wire_mock_caller'
require_relative '../lib/wire_mock_builder'

def reset_mappings
  wire_mock_caller = WireMockCaller.new
  wire_mock_caller.reset_mappings
  wire_mock_caller
end

def get_mapping(wire_mock_caller)
  mappings = wire_mock_caller.get_mappings
  mappings[0]
end

describe WireMock, :integration do

  it 'should be able to create a complicated mapping' do

    wire_mock_caller = reset_mappings

    subject.using_get.
        when_url_equal_to(url = "/testurl").
        when_header_equal_to(
            header_equal_name = "equal",
            header_equal_content = "equal_content").
        when_header_matches(
            header_match_name = "match",
            header_match_content = "match_content").
        when_header_does_not_match(
            header_not_match_name = "not_match",
            header_not_match_content = "not_matching_content").
        when_header_contains(
            header_contains_name = "contains",
            header_contains_content = "contains_content").
        then_return_body("body").
        with_header(
            response_header_name = "response_header",
            response_header_content = "response_header_content").
        create_mapping

    mapping = get_mapping(wire_mock_caller)

    request = mapping['request']
    expect(request['url']).to eq(url)
    expect(request['method']).to eq("GET")

    request_headers = request['headers']

    expect(request_headers[header_equal_name]['equalTo']).to eq(header_equal_content)

    expect(request_headers[header_match_name]['matches']).to eq(header_match_content)

    expect(request_headers[header_not_match_name]['doesNotMatch']).to eq(header_not_match_content)

    expect(request_headers[header_contains_name]['contains']).to eq(header_contains_content)

    response = mapping['response']
    expect(response['status']).to eq(200)
    expect(response['body']).to eq("body")

    headers = response['headers']

    expect(headers[response_header_name]).to eq(response_header_content)

  end


end
