require 'net/http'
require 'json'
require 'httparty'

class WireMockCaller
  include HTTParty
  base_uri "http://localhost:9999/__admin"

  def get_mappings

    response = self.class.get("http://localhost:9999/__admin")

    response["mappings"]

  end

  def create_mapping_old(url, method, body)

    response = self.class.post("/mappings/new",
                               # body: {
                               #     request: {
                               #         method: "GET",
                               #         url: "url"
                               #     },
                               #     response: {
                               #         status: 200,
                               #         body: body,
                               #         headers: {
                               #             :'Content-Type' => "text/plain" # have to use this notation because the dash in Content-Type is not a legal character in a ruby symbol
                               #         }
                               #     }
                               # }
                               body: '{
    "request": {
            "method": "GET",
            "url": "/some/thing"
    },
    "response": {
            "status": 200,
            "body": "Hello world!",
            "headers": {
                    "Content-Type": "text/plain"
            }
    }
}'

    )


    puts response

  end

  def create_mapping(url, method, body)

    mappingRequest = {
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


    response = self.class.post("/mappings/new",
                               body: mappingRequest.to_json
    # body: '{
    # "request": {
    #         "method": "GET",
    #         "url": "/some/thing"
    # },
    # "response": {
    #         "status": 200,
    #         "body": "Hello world!",
    #         "headers": {
    #                 "Content-Type": "text/plain"
    #         }
    # }
    # }'

    )


    puts response

  end


end