class Word < ApplicationRecord
  has_many :games, dependent: :destroy

  validates :text, presents: true, uniqueness: true, format: { with: /\A[[:word:]]+\z/ }
end
