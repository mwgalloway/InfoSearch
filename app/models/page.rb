class Page < ActiveRecord::Base
  validates :url, :title, presence: true
  validates :url, uniqueness: true

  has_many :metrics
  has_many :words, through: :metrics

  def nokogiri=(nokogiri_obj)
    words_to_measure = WordHelper::nokogiri_to_words(nokogiri_obj)
    full_text = WordHelper::text_splitter(nokogiri_obj)
  end
end


Page.new(url: "http://www.spacejam.com", nokogiri: noko_doc)
