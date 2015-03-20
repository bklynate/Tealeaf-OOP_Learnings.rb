# tic tac toe is played between two players, in this case it is computer(O) vs human(X).
# there are 9 moves that make up the board. you must get 3 in a row to win

def say(words)
  puts ">>> #{words}"
end

class Player
  attr_accessor :name, :choice

  def initialize(n)
    @name = n.capitalize  
  end

  def default_choice(board)
    choice = is_space_empty(board).sample
    board[choice] = 'O'
  end

end

class Human < Player

  def choice(board)
    say "Welcome to Tic Tac Toe"
    say "Pick a position (1-9): "
    choice = gets.chomp.to_i
    board[choice] = "X"
  end

  def set_name
    say "What's your name?"
    name = gets.chomp

end

class Computer < Player

end

class Board
  attr_accessor :board

  def initialize
    @board = {}
    (1..9).each{|space| board[space] = ' '}
    board
  end

  def draw_board(board)
    system 'clear'
    say "\n"
    say " #{board[1]}  | #{board[2]} | #{board[3]}"
    say "--------------"
    say " #{board[4]}  | #{board[5]} | #{board[6]}"
    say "--------------"
    say " #{board[7]}  | #{board[8]} | #{board[9]}"
    say "\n"
  end

end

Game.new.start_game
