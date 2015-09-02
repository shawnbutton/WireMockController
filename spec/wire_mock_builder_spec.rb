require 'rspec'
require 'wire_mock_builder'

describe WireMockBuilder do


  it 'should default to a mapping structure' do
    pending

    fail
  end

  it 'should allow you to specify url_pattern when creating mapping' do

    mock_builder = subject.
        uri_matches("/test/.*")

    mapping = mock_builder.mapping
    expect(mapping).to include("urlPattern")

  end

  it 'should allow you to specify body' do
    pending
    # .
    # then_return("body")
    fail
  end


end