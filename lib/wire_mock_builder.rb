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

  def using_get
    request_mapping.merge!(method: "GET")
    self
  end

  def url_matches(url_pattern)
    check_for_url_called_twice
    request_mapping.merge!(urlPattern: url_pattern)
    self
  end

  def url_equal_to(url)
    check_for_url_called_twice
    request_mapping.merge!(url: url)
    self
  end

  def then_return(body)
    @mapping[:response].merge!(body: body)
    self
  end


  private

  def check_for_url_called_twice
    raise 'should not specify url twice' if @url_set
    @url_set = true
  end

  def request_mapping
    @mapping[:request]
  end

end
