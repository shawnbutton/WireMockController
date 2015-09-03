class WireMock

  def initialize(wiremock_caller=WireMockCaller.new)
    @wiremock_caller = wiremock_caller
  end

  def given_that(builder)
    @wiremock_caller.register_mapping(builder.mapping)
  end


end