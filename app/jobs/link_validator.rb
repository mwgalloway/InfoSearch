require 'uri'

class LinkValidator

  @queue = :validate

  def self.perform(link)
    raise "link cannot be nil" if link.nil?
    raise "link is not valid" unless link_valid?(link)
    p "#{link} is valid"

    Resque.enqueue(Crawler, link)
  end


  def self.link_valid?(link)
    forbidden = [".pdf", ".doc", ".js", ".css", ".xls", ".ppt", ".mp3", ".m4v", ".avi", ".mpg", ".rss", ".xml", ".json", ".txt", ".git", ".zip", ".md5", ".asc", ".jpg", ".gif", ".png", "/api", "/cgi-bin", ".php", "/php", "facebook.com", "twitter.com", "?"]
    forbidden.none?{|validation| link.include?(validation)}
  end


end


