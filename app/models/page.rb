
class Page
  include Mongoid::Document

  field :url, type: String
  field :title, type: String
  field :text, type: String
  field :external_links, type: Array

  validates_presence_of :url
  validates_uniqueness_of :url

  def self.add_to_index(args)
    new_page = Page.new(url: args[:url], external_links: args[:external_links])
    new_page.set_nokogiri(args[:noko_doc])
    new_page.save
  end

  def set_nokogiri(nokogiri_obj)
    full_text = WordHelper::text_splitter(nokogiri_obj)
    self.title = nokogiri_obj.css("title").text
    self.text = full_text
    self.save
  end

  def self.search(query, skip)
    Page.collection.
      find({"$text" => {"$search" => query}}).
      projection(text: 1, url: 2, title: 3, score: {"$meta" => "textScore"}).
      sort({score: {"$meta" => "textScore"}}).skip(skip).limit(10)
  end
end
