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
      letter = @guesser.guess_letter(@phrase).downcase
      positions = @checker.check_letter(letter)
      update_phrase(positions, letter) unless positions.nil?
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
checker = ComputerPlayer.new

game = Hangman.new(guesser, checker)
game.run
