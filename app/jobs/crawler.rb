require 'uri'
require 'net/http'
class Crawler
  @queue = :crawl

  def self.perform(page_url)
    uri = URI.parse(page_url)
    response = Net::HTTP.get_response(uri)
    noko_doc = Nokogiri::HTML(response.body)
    links = self.scrape_links(noko_doc)
    links = links.reject { |link| link.nil? }
    links = links.reject {|link| link.include?("javascript")}
    absolute_links = links.select{ |link| link.include?("http")}
    host = uri.host.downcase
    if host.include?("www.")
      host = host[4..-1]
    end
    external_links = absolute_links.reject{ |link| link.include?(host)}
    Page.add_to_index({url: page_url, noko_doc: noko_doc, external_links: external_links})
    joined_links = self.join_relative(page_url, links)
    validate_links(joined_links)
  end

  def self.scrape_links(noko_doc)
    noko_doc.css('a').map { |link| link ["href"] }
  end

  def self.validate_links(links)
    links.each do |link|
      Resque.enqueue(LinkValidator, link)
      p "sent to validator!"
    end
  end

  def self.join_relative(page_url, links)
    links.map do |link|
      p link
      URI.join(page_url, link).to_s
    end
  end
end
