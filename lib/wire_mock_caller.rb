require 'json'
require 'httparty'

class WireMockCaller
  include HTTParty
  base_uri "http://localhost:9999/__admin"

  def get_mappings
    response = self.class.get("http://localhost:9999/__admin")
    response["mappings"]
  end

  def create_mapping(url, method, body)
    mappingRequest = build_mapping_request(body, method, url)
    self.class.post("/mappings/new", body: mappingRequest.to_json)
  end

  def reset_mappings
    self.class.post("/mappings/reset")
  end

  private

  def build_mapping_request(body, method, url)
    {
        request: {
            method: method,
            url: url
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