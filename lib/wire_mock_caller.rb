require 'net/http'
require 'json'

class WireMockCaller


  def get_mappings

    uri = URI('http://localhost:9999/__admin/')
    response = Net::HTTP.get(uri)

    json = JSON.parse(response)

    json["mappings"]

  end


end