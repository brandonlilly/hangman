class ComputerPlayer

  def initialize
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @secret_phrase = ''
    @possibilities = @dictionary
    @guessed = []
  end

  def guess(phrase)
    limit_possibilities(phrase)
    return make_guess(@possibilities.pop) if @possibilities.count < 3
    make_guess(frequent_letter)
  end

  def pick_secret_word
    @secret_phrase = @dictionary.shuffle.find { |word| word.length > 3 }
    @secret_phrase.length
  end

  def check_letter(letter)
    @secret_phrase.chars.each_index.select { |i| @secret_phrase[i] == letter}
  end

  def check_word(word)
    @secret_phrase.downcase == word.downcase
  end

  private

  def limit_possibilities(phrase)
    @possibilities.select! do |word|
      next if word.size != phrase.size
      next if @guessed.any? { |letter| word.include?(letter) && !phrase.include?(letter) }
      next if word.chars.each_with_index.any? do |char, index|
        phrase[index] != nil && phrase[index] != char
      end
      true
    end
  end

  def frequent_letter
    (alphabet - @guessed).max_by do |letter|
      @possibilities.join.count(letter)
    end
  end

  def make_guess(guess)
    @guessed << guess
    puts guess
    guess
  end

  def alphabet
    ('a'..'z').to_a
  end

end
