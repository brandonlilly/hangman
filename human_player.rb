class HumanPlayer

  def pick_secret_word
    puts "How long is the word?"
    loop do
      input = gets.chomp
      return input[/\d+/].to_i if input =~ /\d+/
      puts "Invalid input, please enter a number"
    end
  end

  def guess_letter(phrase)
    print "> "
    loop do
      input = gets.chomp
      return input[/[A-z]/].downcase if input[/[A-z]/]
      puts "Invalid input #{input}, please enter a letter"
    end
  end

  def check_letter(letter)
    puts "Is that letter in your word? (type indexes if so and nothing otherwise)"
    input = gets.chomp
    input.scan(/\d+/).map(&:to_i)
  end

end
