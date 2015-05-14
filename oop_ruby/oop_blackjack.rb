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
    if total > 21
      puts "Game Over, You Lose!"
      game_condition = false
    end 
  end

  def check_for_blackjack(person)
    if person.total == 21
      puts "BLACKJACK!!! #{name.capitalize} has won!"
      game_condition = false
    end  
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
  include Hand
  attr_accessor :player, :deck, :dealer, :try_again_response, :player_choice
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
    begin
      initial_deal(player)
      initial_deal(dealer)
      dealer.dealer_showhand
      player.show_hand
      begin
        check_for_blackjack(player)
        player_turn(player)             
      end until player_choice == 's'
      try_again
    end until try_again_response == "n"
  end

  def try_again
    correct_responses = ['y','n']
    begin
      say 'Try again? [y/n]'
      @try_again_response = gets.chomp.downcase
      say 'Invalid Input !!'unless correct_responses.include?(try_again_response)
    end until correct_responses.include?(try_again_response)
  end

  def player_turn(person)
    begin
      puts "#{person.name}, do you want to [h]it or [s]tay?"
      player_choice = gets.chomp.downcase
      begin
        case player_choice
          when 'h' then person.add_card(deck.deal_one)
          when 's' then "#{person.name} has chosen to stay"
          else 'Not a valid option!'
        end
      end while (person.total not >= 21) or (player_choice == 's')
      system 'clear'
      puts "#{person.show_hand}"
    end until player_choice == 's' or person.total > 21
    if person.total > 21
      puts "BUSTED! GAME OVER!!"
      game_condition = false
    end
  end

  def dealer_turn(dealer)
    while dealer.total < 17
      dealer.add_card(deck.deal_one)
      if dealer.total > 21
        puts "BUSTED! GAME OVER!!"
      end
    puts "#{dealer.show_hand}"
    end
  end
end

Blackjack.new.run_game