require 'uri'

class LinkValidator

  @queue = :links

  def self.perform(uri, link)
    raise "link cannot be nil" if link.nil?
    raise "link is not valid" unless link_valid?(link)
    link = self.concat_relative(uri, link)
    Resque.enqueue(Crawler, link)
  end

  def self.url_relative?(url)
    !url.index(/^https?:\/\//i)
  end

  def self.link_valid?(link)
    forbidden = [".pdf", ".doc", ".js", ".css", ".xls", ".ppt", ".mp3", ".m4v", ".avi", ".mpg", ".rss", ".xml", ".json", ".txt", ".git", ".zip", ".md5", ".asc", ".jpg", ".gif", ".png", "/api", "/cgi-bin", ".php", "/php", "facebook.com", "twitter.com", "?"]
    forbidden.none?{|validation| link.include?(validation)}
  end

  # move this responsibility to crawler, and use URI.join
  def self.concat_relative(parent, link)
    return link unless url_relative?(link)
    if link[0..1] == "//"
      "http:" + link
    elsif link[0] == "/"
      parent + link[1..-1]
    else
      parent + link
    end
  end
end


