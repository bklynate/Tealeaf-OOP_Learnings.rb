module Hand
  def add_card(new_card)
    cards << new_card   
  end

  def show_hand
    puts "-----#{name}'s cards are-----"
    puts "-----#{cards}-----"
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
    total > 21
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
    system 'clear'
    puts "Welcome to Nate's OOP Blackjack"
    @player = Human.new
    @deck = Deck.new
    @dealer = Dealer.new
  end

  def initial_deal(person)
    2.times do
      person.add_card(deck.deal_one)
    end
  end

  def run_game
   initial_deal(player)
   initial_deal(dealer)
   dealer.dealer_showhand 
   player.show_hand
   player_turn(player)
   dealer_turn(dealer)
  end

  def player_turn(person)
    begin
      puts "#{person.name}, do you want to [h]it or [s]tay?"
      player_choice = gets.chomp.downcase
      case player_choice
        when 'h' then person.add_card(deck.deal_one)
        when 's' then "#{person.name} has chosen to stay"
      end
      system 'clear'
      puts "#{person.show_hand}"
    end until player_choice == 's'
  end

  def dealer_turn(dealer)
    while dealer.total < 17
      dealer.add_card(deck.deal_one)
    end
  puts "#{dealer.show_hand}"
  end
end

Blackjack.new.run_game