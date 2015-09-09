module WireMockBuilder

  def mapping
    @mapping ||= {
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

  def when_header_equal_to(header_name, header_content)
    add_request_header(header_name, {equalTo: header_content})
    self
  end

  def when_header_matches(header_name, header_content)
    add_request_header(header_name, {matches: header_content})
    self
  end

  def when_header_does_not_match(header_name, header_content)
    add_request_header(header_name, {doesNotMatch: header_content})
    self
  end

  def when_header_contains(header_name, header_content)
    add_request_header(header_name, {contains: header_content})
    self
  end

  def then_return_body(body)
    mapping[:response].merge!(body: body)
    self
  end

  def with_header(header, content)
    response_headers.merge!(header => content)
    self
  end


  private

  def add_request_header(header_name, header_to_equal)
    request_headers.merge!(header_name => header_to_equal)
  end

  def response_headers
    unless mapping[:response][:headers]
      mapping[:response].merge!(headers: {})
    end
    mapping[:response][:headers]
  end

  def request_headers
    unless mapping[:request][:headers]
      mapping[:request].merge!(headers: {})
    end
    mapping[:request][:headers]
  end

  def check_for_url_called_twice
    raise 'should not specify url twice' if @url_set
    @url_set = true
  end

  def request_mapping
    mapping[:request]
  end

end
