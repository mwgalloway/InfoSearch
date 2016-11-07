require 'uri'
require 'net/http'
class Crawler
  @queue = :crawl

  def self.perform(page_url)
    p page_url
    uri = URI.parse(page_url)
    response = Net::HTTP.get_response(uri)
    noko_doc = Nokogiri::HTML(response.body)
    Page.add_to_index({url: page_url, noko_doc: noko_doc})
    links = self.scrape_links(noko_doc)
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
      URI.join(page_url, link).to_s
    end
  end
end
