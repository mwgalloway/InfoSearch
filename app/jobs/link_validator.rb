class LinkValidator
  def self.perform(uri, link)
    break if link.nil?
    break unless link_valid?(link)
    link = self.concat_relative(uri, link)
    Resque.enqueue(Crawler, link)
  end

  def self.url_relative?(url)
    !url.index(/^https?:\/\//i)
  end

  def self.link_valid?
    forbidden = [".pdf", ".doc", ".js", ".css", ".xls", ".ppt", ".mp3", ".m4v", ".avi", ".mpg", ".rss", ".xml", ".json", ".txt", ".git", ".zip", ".md5", ".asc", ".jpg", ".gif", ".png", "/api", "/cgi-bin", ".php", "/php", "facebook.com", "twitter.com"]
    results = forbidden.any?{|validation| link.include?(validation)}
    results.empty?
  end

  def self.concat_relative(uri, link)
    return link unless url_relative?(link)
    if link [0..1] == "//"
      "http:" + link
    elsif link[0] == "/"
      parent + link[1..-1]
    else
      parent + link
    end
  end
end
