require 'rspec'
require 'wire_mock_builder'

describe WireMockBuilder do

  it 'should allow you to specify url_pattern when creating mapping' do

    pending("need to finish code")

    described_class.
        given_that.
        uri_matches("/test/.*").
        then_return("body").
        go


  end

end