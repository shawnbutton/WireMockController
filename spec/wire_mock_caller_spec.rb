require 'rspec'

describe 'WireMock Calls' do

  it 'should list mappings in json' do

    wiremock = WireMockCaller.new

    mappings = wiremock.getMappings


    expect mappings






    end


end

