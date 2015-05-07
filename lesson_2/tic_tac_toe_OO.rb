# OO Tic Tac Toe

class GameBoard
  
  attr_accessor :board

  def initialize
    @board = {}
    (1..9).each {|position| board[position] = ' ' }
  end

  def place_piece(symbol,pos)
    self.board[pos]= symbol
  end

  def empty_positions
    self.board.keys.select {|position| board[position] == ' '}
  end

  def draw_board
    system 'clear'
    puts
    puts "     |     |"
    puts "  #{self.board[1]}  |  #{self.board[2]}  |  #{self.board[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{self.board[4]}  |  #{self.board[5]}  |  #{self.board[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{self.board[7]}  |  #{self.board[8]}  |  #{self.board[9]}"
    puts "     |     |"
    puts
  end

  def nine_positions_are_filled?
    self.empty_positions == []
  end

  def check_winner
    winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    winning_lines.each do |line|
      return "X" if self.board.values_at(*line).count('X') == 3
      return "O" if self.board.values_at(*line).count('O') == 3
    end
    nil
  end
end

class Player
  attr_accessor :name, :symbol
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class ComputerPlayer < Player
  def computer_places_piece(board)
    position = board.empty_positions.sample
    board.place_piece(self.symbol,position)
  end
end

class HumanPlayer < Player
  def player_places_piece(board)
    begin
      puts "Choose a position (from 1 to 9) to place a piece:"
      position = gets.chomp.to_i
    end until board.empty_positions.include?(position)
    board.place_piece(self.symbol,position)
  end
end


class Game
  def initialize
    system "clear"
    puts "What is your name?"
    player_name = gets.chomp
    begin
      puts "Do you want to play as X or O?"
      puts "Please enter X or O"
      player_symbol=gets.chomp.upcase
    end until player_symbol == "X" || player_symbol == "O"
    @board = GameBoard.new
    @player = HumanPlayer.new(player_name, player_symbol) 
    player_symbol =='X' ? computer_symbol = 'O' : computer_symbol = "X"
    @computer = ComputerPlayer.new(["Bart", "Lisa", "Maggie", "Homer", "Marge"].sample, computer_symbol)
  end

  def welcome_message
    system "clear"
    puts "Welcome to Tic Tac Toe!!"
    puts "Today's exciting matchup features #{@player.name} vs. #{@computer.name} the Computer"
    puts "Good Luck!"
    sleep (2.5)
  end

  def play
    self.welcome_message
    @board.draw_board
    begin
    @player.player_places_piece(@board)
    @board.draw_board
    @computer.computer_places_piece(@board)
    @board.draw_board
    end until !@board.check_winner.nil? || @board.nine_positions_are_filled?

    if @board.check_winner == @player.symbol
      puts "#{@player.name} won. Amazing expert level play!"
    elsif @board.check_winner == @computer.symbol
      puts "#{@computer.name} defeated you ... better luck next time"
    else
      puts "It's a tie ... everyone wins!"
    end

  end

end

g=Game.new
g.play





