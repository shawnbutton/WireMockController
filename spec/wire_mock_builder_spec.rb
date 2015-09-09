require 'rspec'
require 'wire_mock_builder'

describe WireMockBuilder do

  class DummyClass
  end

  before(:each) do
    @subject = DummyClass.new
    @subject.extend(WireMockBuilder)
  end

  it 'should have request and reponse by default' do
    expected_structure = {
        request: {
        },
        response: {
        }
    }
    expect(mapping).to match(expected_structure)
  end

  it 'should allow you to specify url when creating mapping' do
    url = "/test"
    @subject.when_url_matches(url)

    expect(request_mapping).to match(urlPattern: url)
  end

  it 'should allow you to specify url_pattern when creating mapping' do
    url_to_match = "/test/.*"
    @subject.when_url_equal_to(url_to_match)

    expect(request_mapping).to match(url: url_to_match)
  end

  it 'should allow you to specify body' do
    body = "this is some body"
    @subject.then_return_body(body)

    expect(response_mapping).to match(body: body)
  end

  it 'should allow you to specify GET method' do
    @subject.using_get

    expect(request_mapping).to match(method: "GET")
  end

  it 'should raise an exception if url_equal_to and then url_matches are called' do
    call_url_equal_to
    expect { call_url_matches }.to raise_exception
  end

  it 'should raise an exception if url_matches and then url_equal_to are called' do
    call_url_matches
    expect { call_url_equal_to }.to raise_exception
  end

  it 'should raise an exception if url_matches is called twice' do
    call_url_matches
    expect { call_url_matches }.to raise_exception
  end

  it 'should raise an exception if url_equal_to is called twice' do
    call_url_equal_to
    expect { call_url_equal_to }.to raise_exception
  end

  it 'should allow you to specify one return header' do
    name = "header_name"
    content = "header_content"
    @subject.with_header(name, content)

    expect(response_headers[name]).to eq(content)
  end

  it 'should allow you to specify multiple return headers' do
    name_1 = "first_header_name"
    content_1 = "first_header_content"
    name_2 = "second_header_name"
    content_2 = "second_header_content"

    @subject.with_header(name_1, content_1).
        with_header(name_2, content_2)

    expect(response_headers[name_1]).to eq(content_1)
    expect(response_headers[name_2]).to eq(content_2)
  end

  it 'should allow you to specify one request header that must be equal to' do
    name = "header_name"
    content = "header_content"
    @subject.when_header_equal_to(name, content)

    expect(request_headers[name][:equalTo]).to eq(content)

  end

  it 'should allow you to specify multiple request headers' do
    name_1 = "first_header_name"
    content_1 = "first_header_content"
    name_2 = "second_header_name"
    content_2 = "second_header_content"

    @subject.when_header_equal_to(name_1, content_1).
        when_header_equal_to(name_2, content_2)

    expect(request_headers[name_1][:equalTo]).to eq(content_1)
    expect(request_headers[name_2][:equalTo]).to eq(content_2)
  end

  it 'should allow you to specify one request header that must be matched' do
    name = "header_name"
    content = "header_content"
    @subject.when_header_matches(name, content)

    expect(request_headers[name][:matches]).to eq(content)

  end

  it 'should allow you to specify one request header that must NOT be matched' do
    name = "header_name"
    content = "header_content"
    @subject.when_header_does_not_match(name, content)

    expect(request_headers[name][:doesNotMatch]).to eq(content)

  end


end

def mapping
  @subject.mapping
end

def request_mapping
  mapping[:request]
end

def response_mapping
  mapping[:response]
end

def call_url_equal_to
  @subject.when_url_equal_to("/someurl")
end

def call_url_matches
  @subject.when_url_matches("/someurlpattern")
end

def response_headers
  response_mapping[:headers]
end

def request_headers
  request_mapping[:headers]
end

