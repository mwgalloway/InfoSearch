require_relative '../models/word'

module WordHelper
  def self.nokogiri_to_words(nokogiri_obj)
    tag_content= []
    tags = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'li', 'a']

    tags.each do |tag|
      tag_content << nokogiri_obj.css(tag).map { |p| p.inner_text }
    end

    words = []

    tag_content.each do |tag_array|
      tag_array.each do |string|
        string.split(" ").each do |word|
          word = word.downcase
          if !words.include?(word)
            words << word
          end
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

