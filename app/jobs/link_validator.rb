require 'uri'

class LinkValidator
  include Resque::Plugins::UniqueJob
  @queue = :validate
  @@robot = WebRobots.new('InfoBot/1.0')

  def self.perform(link)
    raise "link cannot be nil" if link.nil?
    raise "link is not valid" unless link_valid?(link)
    raise "disallowed on robots.txt" if @@robot.disallowed?(link)
    p "#{link} is valid"

    Resque.enqueue(Crawler, link)
  end


  def self.link_valid?(link)
    forbidden = [".pdf", ".doc", ".js", ".css", ".xls", ".ppt", ".mp3", ".m4v", ".avi", ".mpg", ".rss", ".xml", ".json", ".txt", ".git", ".zip", ".md5", ".asc", ".jpg", ".gif", ".png", "/api", "/cgi-bin", ".php", "/php", "facebook.com", "twitter.com", "?"]
    forbidden.none?{|validation| link.include?(validation)}
  end


end


