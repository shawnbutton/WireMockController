require 'httparty'
require 'multi_json'
require 'securerandom'

class WireMock

  def initialize
    @debug = 1

    @wiremock_host = FigNewton.wiremock_server('localhost')
    @wiremock_port = FigNewton.wiremock_port(8888).to_s

    @wiremock_url_prefix = "http://#{@wiremock_host}:#{@wiremock_port}"

    @cookie_name = 'x-wm'
  end

  def configure_response(json_filename, http_verb, request_uri, match_context = {}, priority = 10, http_status = 200, urlUsesPattern = false)
    json_data = get_json_data json_filename
    match_expression = generate_match_expression(match_context)
    mapping = generate_mapping(request_uri, http_verb, http_status, json_data, match_expression, priority, urlUsesPattern)
    print_debug_info json_filename, http_verb, request_uri, match_expression
    HTTParty.post("#{@wiremock_url_prefix}/__admin/mappings/new", {:body => mapping})
  end

  def get(uri, match_string)
    HTTParty.get("#{@wiremock_url_prefix}/#{uri}", cookies: {@cookie_name => match_string})
  end

  def generate_mock_cookie
    return "#{@cookie_name}=#{generate_uuid}" if @match_context.nil? || @match_context.empty?
    "#{@cookie_name}=#{@match_context.keys.collect { |v| @match_context[v.to_sym] }.join('-')}"
  end


  def generate_mock_cookie_value
    return "#{generate_uuid}" if @match_context.nil? || @match_context.empty?
    "#{@match_context.keys.collect { |v| @match_context[v.to_sym] }.join('-')}"
  end

  private

  def print_debug_info(json_filename, http_verb, request_uri, match_expression)
    if @debug == 1
      if match_expression.nil?
        puts "Adding mapping for #{http_verb} method on #{request_uri} from #{json_filename} without any match_expression"
      else
        puts "Adding mapping for #{http_verb} method on #{request_uri} from #{json_filename} with match_expression of #{match_expression}"
      end
    end
  end

  def get_json_data json_filename
    file_path = File.expand_path("./features/mocks/#{json_filename}")
    if (!File.exist?(file_path))
      file_path = File.expand_path("../ecuke-common/common-mocks/#{json_filename}")
    end

    json_data = File.read(file_path)
  end

  def generate_uuid
    @match_uuid ||= SecureRandom.uuid
  end

  def generate_match_expression(match_context = {})
    return nil if match_context.nil?
    return ".*#{@cookie_name}=#{generate_uuid}.*" if match_context.empty?

    ".*#{@cookie_name}=" << match_context.keys.collect { |v| match_context[v.to_sym] }.join('-') << '.*'
  end

  def generate_mapping(request_uri, http_verb, http_status, response_body, match_expression, priority = 10, urlUsesPattern = false)
    if urlUsesPattern
      request = {:method => http_verb, :urlPattern => request_uri}
    else
      request = {:method => http_verb, :url => request_uri}
    end

    request.merge!({:headers => {:cookie => {:matches => match_expression}}}) unless match_expression.nil?

    response = {:status => http_status, :body => response_body, :headers => {'Content-Type' => 'application/json'}}
    mapping = {:request => request, :response => response, :priority => priority}
    MultiJson.dump(mapping)
  end

end