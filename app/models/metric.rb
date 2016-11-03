class Metric < ActiveRecord::Base
  validates :first_position, :frequency, :page_id, :word_id, presence: true

  belongs_to :page
  belongs_to :word
end
