require_relative 'human_player'
require_relative 'computer_player'

class Hangman

  def initialize(guessing_player, checking_player)
    @guesser = guessing_player
    @checker = checking_player
  end

  def run
    length = @checker.pick_secret_word
    @phrase = Array.new(length)
    until @phrase.none?(&:nil?)
      puts "Secret word: #{render}"
      guess = @guesser.guess(@phrase).downcase
      if guess.length == 1
        positions = @checker.check_letter(guess)
        update_phrase(positions, guess) unless positions.nil?
      else
        @phrase = guess.split('') if @checker.check_word(guess)
      end
    end
    puts "\nYou got it. The word was '#{render}'!"
  end

  def update_phrase(positions, letter)
    postions = [positions].flatten
    positions.each { |position| @phrase[position] = letter }
  end

  def render
    @phrase.map {|char| char || '_'}.join
  end

end

guesser = ComputerPlayer.new
checker = HumanPlayer.new

game = Hangman.new(guesser, checker)
game.run
