require 'json'
require 'httparty'

class WireMockCaller
  include HTTParty

  def initialize(base_uri = "http://localhost:9999/__admin")
    WireMockCaller.base_uri base_uri
  end

  def get_mappings
    response = self.class.get("")
    response["mappings"]
  end

  def create_mapping(url, method, body)
    mapping_request = build_mapping_request(method, body, url)
    self.class.post("/mappings/new", body: mapping_request.to_json)
  end

  def reset_mappings
    self.class.post("/mappings/reset")
  end

  private

  def build_mapping_request(method, body, url)
    url_or_url_pattern = "url"
    {
        request: {
            method: method,
            url_or_url_pattern => url
        },
        response: {
            status: 200,
            body: body,
            headers: {
                :'Content-Type' => "text/plain" # have to use this notation because the dash in Content-Type is not a legal character in a ruby symbol
            }
        }
    }
  end

end