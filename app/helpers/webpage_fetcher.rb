require 'net/http'
require 'uri'
require 'nokogiri'

module WebpageFetcher
  def self.parse(webpage)
    uri = URI.parse(webpage)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    nokogiri_document = Nokogiri.parse(response.body)
  end
end
