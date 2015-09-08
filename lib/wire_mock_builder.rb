module WireMockBuilder

  def mapping
    @mapping ||= {
        request: {
        },
        response: {
        }
    }
  end

  def given_that()
    self
  end

  def using_get
    request_mapping.merge!(method: "GET")
    self
  end

  def when_url_matches(url_pattern)
    check_for_url_called_twice
    request_mapping.merge!(urlPattern: url_pattern)
    self
  end

  def when_url_equal_to(url)
    check_for_url_called_twice
    request_mapping.merge!(url: url)
    self
  end

  def then_return_body(body)
    mapping[:response].merge!(body: body)
    self
  end

  def with_header(header, content)
    response_headers.merge!(header.to_s => content)
    self
  end

  def response_headers
    unless mapping[:response][:headers]
      mapping[:response].merge!(headers: {})
    end
    mapping[:response][:headers]
  end


  def when_header_equal_to(header_name, header_content)
    header_equal_matcher = {equalTo: header_content}
    request_headers.merge!(header_name.to_s => header_equal_matcher)
    self
  end

  def request_headers
    unless mapping[:request][:headers]
      mapping[:request].merge!(headers: {})
    end
    mapping[:request][:headers]
  end


  private

  def check_for_url_called_twice
    raise 'should not specify url twice' if @url_set
    @url_set = true
  end

  def request_mapping
    mapping[:request]
  end

end
