class Crawler
  attr_accessor :links_to_scrape, :link_bucket
  def initialize
    @links_to_scrape = []
    File.foreach("links") {|link| self.links_to_scrape << link}
    @link_bucket = []
    @url = ''
  end

  def scrape
    get_response = RestClient.get(self.url)
    noko_doc = Nokogiri::HTML(get_response.to_s)
    parse_links(noko_doc, url)
  end

  def url_relative?
    !self.url.match(/^https?:\/\//i)
  end

  def parse_links(noko_doc, url)
    parent_directory = url[0..url.rindex("/")]
    links = noko_doc.css('a').map { |link| link ["href"] }
  end

end
