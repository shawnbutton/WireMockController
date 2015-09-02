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


  def uri_matches(urlPattern)
    @mapping = "urlPattern"

    self
  end


  def then_return(body)
    self
  end

  def mapping
    @mapping
  end


end