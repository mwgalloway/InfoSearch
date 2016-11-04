class Crawler
  def scrape(url)
    parent_directory = url[0..url.rindex("/")]
    noko_doc = Nokogiri::HTML(get_response.to_s)
    links = noko_doc.css('a').map { |link| link ["href"] }
  end

end
