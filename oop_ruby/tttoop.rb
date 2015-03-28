def say(words)
  puts ">>> #{words}"
end

class Player
  attr_accessor :name, :choice

  def initialize(name)
    @name = name
  end
end

class Human < Player

  def choice(board)
    say "Pick a 'square' #{name}, choose (1-9) to play:"
    human_choice = gets.chomp.to_i
    board.board[human_choice] = "X"
  end

  def set_name
    say "What is your name player?"
    self.name = gets.chomp.capitalize
  end
end

class Computer < Player

  def initialize(name="R2D2")
    @name = name
  end
  
  def choice(board)
    computer_choice = board.empty_spaces.sample
    board.board[computer_choice] = 'O'
  end
end

class Board
  attr_accessor :board

  def initialize
    @board = {}
    (1..9).each { |space| board[space] = ' ' }
  end

  def clear_board
    @board = {}
    (1..9).each { |space| board[space] = ' ' }
  end
 
  def draw_board
    system 'clear'
    say "\n"
    say " #{board[1]}  | #{board[2]} | #{board[3]}"
    say "--------------"
    say " #{board[4]}  | #{board[5]} | #{board[6]}"
    say "--------------"
    say " #{board[7]}  | #{board[8]} | #{board[9]}"
    say "\n"
  end

  def empty_spaces
    board.select { |_,v| v == ' '}.keys
  end 
end

class Game
  attr_accessor :board, :computer, :human
  attr_reader :try_again_response
  
  def initialize
    @board = Board.new
    @human = Human.new("")  
    @computer = Computer.new
  end

  def try_again
    correct_responses = ['y','n']
    begin
      say "Try again? [y/n]"
      @try_again_response = gets.chomp.downcase
      say "Invalid Input !!" unless correct_responses.include?(try_again_response)
    end until correct_responses.include?(try_again_response)
  end

  def start_game
    human.set_name
    begin
      board.clear_board
      begin
        board.draw_board
        human.choice(board)
        check_for_winner
        computer.choice(board)
        check_for_winner
        winner = check_for_winner
      end until winner || board.empty_spaces.empty?
      board.draw_board
      if winner
        say winner
      else
        say "It's a tie"
      end
      try_again
    end until try_again_response == "n"
  end

  def check_for_winner
    winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    winning_lines.each do |line|
      return "Congrats #{human.name}, You Won!!" if board.board.values_at(*line).count('X') == 3
      return "#{computer.name} Won!!" if board.board.values_at(*line).count('O') == 3
    end
    nil
  end 
end

Game.new.start_game