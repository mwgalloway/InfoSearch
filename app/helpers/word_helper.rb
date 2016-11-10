
module WordHelper
  def self.nokogiri_to_words(nokogiri_obj)

    tag_content= []
    tags = ['title', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'li', 'a']

    tags.each do |tag|
      tag_content << nokogiri_obj.css(tag).map { |p| p.inner_text.split(" ") }
    end
    tag_content.flatten!

    words = []

    join_tag_content_for_downcase = tag_content.join(" ")
    downcased_tag_content = join_tag_content_for_downcase.downcase
    tag_content = downcased_tag_content.split(" ")
    tag_content.uniq!
    tag_content = tag_content[0..299]
    joined_content = tag_content.join(" ")
    joined_content.gsub!(/[!@&"'?.#*^+=-_%$`~|]/,'')
    puncuation_free_content = joined_content.split(" ")

    puncuation_free_content.uniq!
    words
  end

  def self.text_splitter(nokogiri_obj)
    tag_content= []
    tags = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'li', 'a']

    tags.each do |tag|
      tag_content << nokogiri_obj.css(tag).map { |p| p.inner_text.downcase }
    end
    tag_content.flatten.join(" ").split(" ")[0..299].join(" ")
  end
end

