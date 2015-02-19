class HumanPlayer

  def pick_secret_word
    puts "How long is the word?"
    loop do
      input = gets.chomp
      return input[/\d+/].to_i if input =~ /\d+/
      puts "Invalid input, please enter a number"
    end
  end

  def guess(phrase)
    print "> "
    loop do
      input = gets.chomp.downcase
      return input[/[A-z]+/] if input[/[A-z]+/]
      puts "Invalid input #{input}, please enter a letter"
    end
  end

  def check_letter(letter)
    puts "Is that letter in your word? (type indexes if so and nothing otherwise)"
    input = gets.chomp
    input.scan(/\d+/).map(&:to_i)
  end

  def check_word(word)
    puts "Is that the correct word? (y/n)"
    gets.chomp.downcase == 'y'
  end

end
