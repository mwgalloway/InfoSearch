class Metric < ActiveRecord::Base
  validates :first_position, :frequency, :page_id, :word_id, presence: true

  belongs_to :page
  belongs_to :word

  def ranking
    (self.frequency.to_f / self.first_position.to_f)
  end
end

# word1 = Word.find_by(text: "Schiller")
# word1.metrics.sort {|a,b| b.ranking <=> a.ranking}
