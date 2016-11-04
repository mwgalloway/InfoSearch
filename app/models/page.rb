class Page < ActiveRecord::Base
  validates :url, :title, presence: true
  validates :url, uniqueness: true

  has_many :metrics
  has_many :words, through: :metrics

  def nokogiri=(nokogiri_obj)
    words_to_measure = WordHelper::nokogiri_to_words(nokogiri_obj)
    full_text = WordHelper::text_splitter(nokogiri_obj)
    self.title = nokogiri_obj.css("title").text
    words_to_measure.each do |word_to_measure|
      position = full_text.index(word_to_measure.text) + 1
      frequency = full_text.select{ |text_word| text_word == word_to_measure.text }.count
      self.metrics.create(word: word_to_measure, first_position: position, frequency: frequency)
    end
  end
end

