def say(words)
  puts "> #{words}"
end

class Hand
  include Comparable
  
  attr_reader :type
  
  def initialize(t)
    @type = t
  end
  
  def <=>(other_weapon)
    if @type == other_weapon.type
      0
    elsif (@type == "r" && other_weapon.type == "s") || (@type == "p" && other_weapon.type == "r") || (@type == "s" && other_weapon.type == "p")
      1
    else
      -1
    end
  end

  def display_winning_message
    case @type
    when 'p'
      say "Paper wraps Rock!"
    when 'r'
      say "Rock smashes Scissors!"
    when 's'
      say "Scissors shreds Paper!"
    end
  end
end

class Player
  attr_accessor :name, :hand
  
  def initialize(n)
    @name = n.capitalize
  end

  def set_name
    say "Hey, what is your name?"
    @name = gets.chomp.capitalize
    say ''
  end
end

class Human < Player
  def hand_pick
    say "Pick either 'r' : Rock | 'p' : Paper | 's' : Scissors"
    begin
      h = gets.chomp.downcase
      say "Input Invalid: Pick either 'r' : Rock | 'p' : Paper | 's' : Scissors" unless Game::CHOICES.keys.include?(h)       
    end until Game::CHOICES.keys.include?(h)
    self.hand = Hand.new(h)
  end
end

class Computer < Player
  def initialize(n="computer")
    self.name = n.capitalize
  end

  def hand_pick
    self.hand = Hand.new(Game::CHOICES.keys.sample)
  end
end

class Game
  attr_accessor :player, :computer

  CHOICES =  {"r" => "Rock", "p" => "Paper", "s" => "Scissors"}

  def initialize
    @player = Human.new('')
    @computer = Computer.new
  end

  def start_game
    player.set_name
    say "Hello #{player.name}, welcome to the rps challange."
    player.hand_pick
    computer.hand_pick
    compare_hands
  end

  def compare_hands
    if player.hand == computer.hand
      say "It's a tie!"
    elsif player.hand > computer.hand
      player.hand.display_winning_message
      say "#{player.name} won!"
    else
      computer.hand.display_winning_message
      say "#{computer.name} won!"
    end
  end
end

game = Game.new.start_game