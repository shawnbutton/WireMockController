require 'rspec'
require 'wire_mock_builder'

def mapping
  subject.mapping
end

def request_mapping
  mapping[:request]
end

def response_mapping
  mapping[:response]
end

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
    url_to_match = "/test"
    subject.url_matches(url_to_match)

    expect(request_mapping).to match(urlPattern: url_to_match)
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

end