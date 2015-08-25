require "wire_mock_controller/version"

module WireMockController

  class WireMockController

    attr_reader :wiremock_caller

    def initialize(wiremock_caller=WireMockController.new)
      @wiremock_caller = wiremock_caller
    end

    # def givenThat(get(urlEqualTo("/whatever"))).

  end


end
