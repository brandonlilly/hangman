class ComputerPlayer

  def initialize
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @secret_phrase = ''
    @possibilities = @dictionary
    @guessed = []
  end

  def guess_letter(phrase)
    guess = intelligent_guess(phrase)
    @guessed << guess
    puts guess
    guess
  end

  def pick_secret_word
    @secret_phrase = @dictionary.shuffle.find { |word| word.length > 3 }
    @secret_phrase.length
  end

  def check_letter(letter)
    @secret_phrase.chars.each_index.select { |i| @secret_phrase[i] == letter}
  end

  private

  def random_guess(phrase)
    (alphabet - @guessed).sample
  end

  def intelligent_guess(phrase)
    @possibilities.select! do |word|
      next false if word.size != phrase.size
      next false if @guessed.any? { |letter| word.include?(letter) && !phrase.include?(letter) }
      next false if word.chars.each_with_index.any? do |char, index|
        phrase[index] != nil && phrase[index] != char
      end
      true
    end

    (alphabet - @guessed).sort_by do
      |letter| @possibilities.join.count(letter)
    end.last
  end

  def alphabet
    ('a'..'z').to_a
  end

end
