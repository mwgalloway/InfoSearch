class Crawler
  attr_accessor :links_to_scrape, :link_bucket, :current_url
  def initialize
    @links_to_scrape = []
    File.foreach("links") {|link| self.links_to_scrape << link}
    @link_bucket = []
  end

  def scrape
    get_response = RestClient.get(self.current_url)
    noko_doc = Nokogiri::HTML(get_response.to_s)
    parse_links(noko_doc)
  end

  def url_relative?(url)
    !url.match(/^https?:\/\//i)
  end

  def concat_relative(parent, relative)
    if relative[0] == "/"
      parent + relative[1..-1]
    else
      parent + relative
    end
  end

  def parse_links(noko_doc)
    parent_directory = self.current_url[0..self.current_url.rindex("/")]
    links = noko_doc.css('a').map { |link| link ["href"] }
    links.select { |link| url_relative?(link) }.each{ |link| link = concat_relative(parent_directory, link) }
  end

end
