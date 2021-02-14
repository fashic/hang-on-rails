class Game < ApplicationRecord
  TOTAL_ERRORS_ALLOWED = 7

  belongs_to :word

  scope :sorted, -> { order(created_at: :desc) }

  def errors_letters
    guesses - normalized_letters
  end

  def errors_made
    errors_letters.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    letters.map do |letter|
      letter if guesses.include?(normalize_letter(letter))
    end
  end

  def lost?
    errors_allowed.zero?
  end

  def normalize_letter(letter)
    return 'И' if letter == 'Й'
    return 'Е' if letter == 'Ё'

    letter
  end

  def normalized_letters
    letters.map(&method(:normalize_letter))
  end

  def over?
    won? || lost?
  end

  def play!(letter)
    unless over? || guesses.include?(normalize_letter(letter))
      guesses << normalize_letter(letter)
    end
  end

  def won?
    (normalized_letters - guesses).empty?
  end

  def letters
    word.letters
  end
end
