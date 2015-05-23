module Hand
  def add_card(new_card)
    cards << new_card   
  end

  def show_hand
    puts "-----#{name}'s cards are-----"
    puts "-----#{cards[0]}, #{cards[1]}-----"
    puts "-----#{name}'s total: #{total}-----"  
    puts ''
  end

  def dealer_showhand
    puts "-----#{name}'s cards are-----"
    puts "-----#{cards[0]}, ??-----"
    puts '' 
  end

  def total
    face_values = cards.map{ |card| card.face_value }
    total = 0

    face_values.each do |card|
      if card == 'A'
        total += 11
      elsif card.to_i == 0
        total += 10
      else
        total += card
      end
    end

    face_values.select { |card| card == 'A'}.count.times do
      total -= 10 if total > 21
    end

    total
  end

  def is_busted?
    puts "Game Over, You Lose!" if total > 21
  end

  def blackjack?
    puts "BLACKJACK!!! #{name.capitalize} has won!" if total == 21
  end
end

class Card
  attr_accessor :suit, :face_value
  attr_reader :proper_suit_name
  def initialize(suit,facevalue)
    @suit = suit
    @face_value = facevalue
  end

  def to_s
    "#{proper_suit_name}[#{face_value}]"
  end

  def proper_suit_name
    case suit
      when 'H' then 'Hearts'
      when 'S' then 'Spades'
      when 'C' then 'Clubs'
      when 'D' then 'Diamonds'
    end 
  end

  def size
    cards.size
  end 
end

class Deck
  attr_accessor :cards
  def initialize
    @cards = []
    ['H','S','C','D'].each do |suit|
      [2,3,4,5,6,7,8,9,10,"K","Q",'J','A'].each do |facevalue|
        @cards << Card.new(suit,facevalue)
      end
    end
    shuffle_cards!
  end

  def shuffle_cards!
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end

  def size
    cards.size
  end
end

class Human
  include Hand
  attr_accessor :cards
  attr_reader :name
  def initialize
    puts "Hello player, What is your name?"
    @name = gets.chomp.capitalize
    @cards = []
  end
end

class Dealer
 include Hand
 attr_accessor :cards
 attr_reader :name
  def initialize
    @name = "Dealer"
    @cards = []
  end
end 

class Blackjack
  attr_accessor :player, :deck, :dealer
  def initialize
    puts "Welcome to Nate's OOP Blackjack"
    @player = Human.new
    @deck = Deck.new
    @dealer = Dealer.new
  end

  def clear
    system 'clear'
  end

  def initial_deal
    2.times{player.add_card(deck.deal_one)}
    2.times{dealer.add_card(deck.deal_one)}
  end

  def blackjack?
    if player.total == 21
      puts "Congrats, you have hit Blackjack - You Win!!"
      try_again
    end
  end

  def busted?
    if player.total > 21
      puts "You've Busted! - Game Over"
      try_again
    end
  end

  def try_again
    puts 'Would you like to try again?[y/n]'
    choice = gets.chomp.downcase

    if !['y','n'].include?(choice)
      puts "\nInvalid choice, choose 'y' or 'n'"
      try_again
    end

    case choice
    when 'y'
      reset_hands
      run
    when 'n'
      exit
    end
  end

  def reset_hands
    if deck.size < 25
      deck = Deck.new
    end
    player.cards = []
    dealer.cards = []
  end

  def run
    initial_deal  
    dealer.dealer_showhand
    player.show_hand
    human_choice
    dealer_choice
    who_won?
    try_again
  end

  def who_won?
    if player.total == dealer.total
      puts "It's a tie!"
    elsif player.total > dealer.total
      puts "#{player.name}'s Total: #{player.total}"
      puts "#{player.name} won!"
    else
      puts "Dealer's Total: #{dealer.total}"
      puts "#{dealer.name} won!"
    end
  end

  def dealer_turn
    dealer_choice
  end

  def human_choice
    puts "Would you like to [h]it or [s]tay?"
    choice = gets.chomp.downcase

    if !['h','s'].include?(choice)
      puts "\nInvalid choice, try again."
      human_choice
    end

    case choice
    when 'h'
      new_card = deck.deal_one
      player.add_card(new_card)
      puts "#{player.name} was dealt: #{new_card}"
      puts "#{player.name}'s total: #{player.total}"
      human_choice unless blackjack? || busted? || choice.include?('s')
    when 's'
      puts "#{player.name} chose stay"
    end
  end

  def dealer_choice
    while dealer.total < 17
      new_card = deck.deal_one
      dealer.add_card(new_card)
      puts "#{dealer.name} was dealt: #{new_card}"
      puts "#{dealer.name}'s total: #{dealer.total}"
      dealer_choice unless blackjack? || busted?
    end
  end
end

Blackjack.new.run