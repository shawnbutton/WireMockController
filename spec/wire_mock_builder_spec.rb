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

    expect(subject.mapping).to match(expected_structure)
  end

  it 'should allow you to specify url_pattern when creating mapping' do

    pending("check for proper url")
    mock_builder = subject.
        uri_matches("/test/.*")

    mapping = mock_builder.mapping
    expect(mapping).to include("urlPattern")

    fail
  end

  it 'should allow you to specify body' do
    pending
    # .
    # then_return("body")
    fail
  end


end