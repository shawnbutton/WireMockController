require 'wire_mock_builder'

class WireMock

  include WireMockBuilder

  def initialize(wiremock_caller=WireMockCaller.new)
    @wiremock_caller = wiremock_caller
  end

  def create_mapping()
    @wiremock_caller.register_mapping(mapping)
  end


end