class Page < ActiveRecord::Base
  validates :url, :title, presence: true
  validates :url, uniqueness: true

  has_many :metrics
  has_many :words, through: :metrics
end
