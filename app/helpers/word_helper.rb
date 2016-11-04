require_relative 'webpage_fetcher'
require_relative '../models/word'

nokogiri_obj = WebpageFetcher.parse("http://www.w3schools.com/html/html_basic.asp")

module WordHelper
  def self.nokogiri_to_words(nokogiri_obj)
    tag_content = nokogiri_obj.css('h1').map {|p| p.inner_text }
    tag_content += nokogiri_obj.css('h2').map {|p| p.inner_text }
    tag_content += nokogiri_obj.css('h3').map {|p| p.inner_text }
    tag_content += nokogiri_obj.css('h4').map {|p| p.inner_text }
    tag_content += nokogiri_obj.css('h5').map {|p| p.inner_text }
    tag_content += nokogiri_obj.css('h6').map {|p| p.inner_text }
    tag_content += nokogiri_obj.css('p').map {|p| p.inner_text }
    tag_content += nokogiri_obj.css('li').map {|p| p.inner_text }
    tag_content += nokogiri_obj.css('a').map {|p| p.inner_text }

    words = []

    tag_content.each do |content|
      content.split(" ").each do |word|
        word = word.downcase
        if !words.include?(word)
          words << word
        end
      end
    end

    words
  end

  def self.create_words(words_array)
    words = []
    words_array.each do |word|
      new_word = Word.new(text: word)
      new_word.save
      words << new_word
    end
    words
  end
end

words_array = WordHelper.nokogiri_to_words(nokogiri_obj)
words_obj = WordHelper.create_words(words_array)
p words_obj

