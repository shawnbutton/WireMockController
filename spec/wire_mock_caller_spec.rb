require_relative '../lib/wire_mock_caller'
require 'spec_helper'

describe 'WireMock Caller Tests' do

  before :each do
    @sut = WireMockCaller.new
  end

  it 'should throw exception when you specify invalid wiremock uri' do

    pending("code is not implemented")

    @sut = WireMockCaller.new('http://someinvaliduri/')

    expect { @sut.get_mappings }.to raise_exception

  end

end

