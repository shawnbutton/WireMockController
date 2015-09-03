require 'rspec'
require 'wire_mock_builder'

describe WireMockBuilder do

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
    subject.url_matches(url)

    expect(request_mapping).to match(urlPattern: url)
  end

  it 'should allow you to specify url_pattern when creating mapping' do
    url_to_match = "/test/.*"
    subject.url_equal_to(url_to_match)

    expect(request_mapping).to match(url: url_to_match)
  end

  it 'should allow you to specify body' do
    body = "this is some body"
    subject.then_return(body)

    expect(response_mapping).to match(body: body)
  end

  it 'should allow you to specify GET method' do
    subject.using_get

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

end


def mapping
  subject.mapping
end

def request_mapping
  mapping[:request]
end

def response_mapping
  mapping[:response]
end

def call_url_equal_to
  subject.url_equal_to("/someurl")
end

def call_url_matches
  subject.url_matches("/someurlpattern")
end
