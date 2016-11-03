class Word < ActiveRecord::Base
  validates :text, presence: true, uniqueness: true

  has_many :metrics
  has_many :pages, through: :metrics
end
