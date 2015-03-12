# The game should begin with a player welcome. It should ask the player their name and use the player's
# name throughout the game. Computer and Player both have access to same options of rock paper or scissors 
# well as being able to do the same things.

def say(words)
  puts "> #{words}"
end


class PlayableCharacter
  
  attr_accessor :name 
  attr_reader :hand
  
  def initialize(n="computer")
    @name = n.capitalize
  end

  def display_winning_message
   case hand
   when 'p'
    say "Paper wraps Rock!"
   when 'r'
    say "Rock smashes Scissors!"
   when 's'
    say "Scissors shreds Paper!"
   end
  end

end


class Human < PlayableCharacter
    
  def hand_pick
    say "Pick either 'r' : Rock | 'p' : Paper | 's' : Scissors"
    begin
      @hand = gets.chomp
      say "Input Invalid: Pick either 'r' : Rock | 'p' : Paper | 's' : Scissors" unless Game::CHOICES.keys.include?(hand)       
    end until Game::CHOICES.keys.include?(hand)
    hand
  end

end


class Computer < PlayableCharacter

  def hand_pick
    @hand = Game::CHOICES.keys.sample
    hand
  end

end

class Game
  include Comparable

  attr_reader :player, :computer

  CHOICES =  {"r" => "Rock", "p" => "Paper", "s" => "Scissors"}

  def initialize
    @computer = Computer.new
  end

  def welcome_player
    say "What is your name?"
    p_name = gets.chomp
    @player = Human.new(p_name)
    say "Welcome #{player.name}, This is the 'R'ock - 'P'aper - 'S'cissors Challenge"
    player
  end

  def start_game
    welcome_player
    player.hand_pick
    computer.hand_pick
    compare_hands
    try_again
  end

  def try_again
    begin
      a = ['y','n']
      say "Try Again?[y/n] "
      answer = gets.chomp.downcase
      say "Invalid Input !!" unless a.include?(answer)
    end until a.include?(answer)
    answer
    if answer == 'y'
      game = Game.new.start_game
      game
    else
      answer == 'n'
      exit
    end
  end

  def <=>(other_hand)
    if @value == other_hand.value
      0
    elsif (@value == 'p' && other_hand.value == 'r') ||
          (@value == 'r' && other_hand.value == 's') ||
          (@value == 's' && other_hand.value == 'p')
      1
    else
      -1
    end
  end

  def compare_hands
    if player.hand == computer.hand
      say "It's a tie!"
    elsif player.hand > computer.hand
      player.display_winning_message
      say "#{player.name} won!"
    else
      computer.display_winning_message
      say "#{computer.name} won!"
    end
  end
  
end

game = Game.new.start_game
game