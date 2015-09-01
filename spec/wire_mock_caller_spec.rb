require_relative '../lib/wire_mock_caller'
require 'spec_helper'

describe 'WireMock Caller Tests' do

  before :each do
    @sut = WireMockCaller.new
  end

  it 'should allow you to specify url_pattern when creating mapping' do

    pending
    @sut.create_mapping("/test", :GET, "body")


    fail


  end

end

