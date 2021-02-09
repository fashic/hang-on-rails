class Word < ApplicationRecord
  validates :text, presents: true, uniqueness: true, format: { with: /\A[[:word:]]+\z/ }
end
