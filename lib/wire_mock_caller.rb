require 'net/http'
require 'json'

class WireMockCaller


  def get_mappings

    uri = URI('http://localhost:9999/__admin')
    response = Net::HTTP.get(uri)

    json = JSON.parse(response)

    json["mappings"]

  end

  def create_mapping(url, method, body)

    uri = URI('http://localhost:9999/__admin/mappings/new')
    response = Net::HTTP.put(uri)

    json = JSON.parse(response)

    json["mappings"]


  end


end