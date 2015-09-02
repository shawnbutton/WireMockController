class WireMockBuilder

  attr_reader :mapping

  def initialize
    @mapping = {
        request: {
        },
        response: {
        }
    }
  end

  def given_that
    self
  end

  def url_matches(url_pattern)
    @mapping[:request].merge!(:urlPattern => url_pattern)

    self
  end

  def then_return(body)
    self
  end

end