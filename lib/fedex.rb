require 'net/http'
require 'uri'
require 'nokogiri'
require 'nori'
require 'erb'

require_relative "fedex/version"

module Fedex
  class Error < StandardError; end
  class ParsingError < StandardError; end
  class UnexpectedResponseError < StandardError; end

  def self.parse_body(response)
    return nil if response.nil?

    begin
      xml = Nokogiri::XML(response.body)
      parser = Nori.new
      body_data = parser.parse(xml.to_s)
      {:code => response.code, :body => body_data}
    rescue => e
      raise ParsingError, "Error parsing XML: #{e.message}"
    end
  end

  class Rates
    URL = "https://wsbeta.fedex.com:443/xml"
    TEMPLATES_DIR = File.expand_path('../lib/templates', __dir__)

    class << self
      def get(credentials, rate_params)
        request = build_request(credentials, rate_params)
        response = send_request(request)
        parse_response(response)
      end

      private

      def build_request(credentials, rate_params)
        template = ERB.new(File.read(File.join(TEMPLATES_DIR, 'request_template.xml.erb')))
        puts "params son"
        puts credentials
        puts rate_params
        puts template
        xml = template.result(binding)

        request = Net::HTTP::Post.new(URI.parse(URL))
        request.content_type = "text/xml"
        request.body = xml
        request
      end

      def send_request(request)
        uri = URI.parse(URL)
        req_options = {
          use_ssl: uri.scheme == "https",
        }
        begin
          response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
            http.request(request)
          end
        rescue StandardError => e
          raise Fedex::Error, "#{e.message}"
        end
        response
      end

      def parse_response(response)
        parsed_body = Fedex.parse_body(response)
        if response.code == "200"
          parsed_body
        else
          raise UnexpectedResponseError, {:message => "Unexpected response code: #{response.code}", :body => parsed_body}
        end
      end
    end
  end
end
