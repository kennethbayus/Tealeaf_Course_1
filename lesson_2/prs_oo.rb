# OO Paper rock scissors game

class Hand
  attr_accessor :value
  def initialize(v)
    @value = v
  end
end

class PlayerHand < Hand
  def initialize
    self.value = get_player_choice
  end

  def get_player_choice
    input=""
    until input =="p" || input =="r" || input =="s" do 
      puts "Please enter P, R or S"
      input=gets.chomp.downcase
    end 
    return input
  end

end

class ComputerHand < Hand
  def initialize
    self.value = get_computer_choice
  end

  def get_computer_choice
    ["p","r","s"].sample
  end
end

#Methods for comparing hands go in the main game
class Game

  @@games_played = 0
  @@wins = 0
  @@losses = 0
  @@ties = 0

  def initialize
  end

  def self.games_played
    @@games_played
  end 

  def self.wins
    @@wins
  end 

  def evaluate_game(player_hand, computer_hand)
    puts "You chose #{player_hand.value}"
    puts "The computer chose #{computer_hand.value}"
    if (player_hand.value == "p" && computer_hand.value == "r") || (player_hand.value  == "r" && computer_hand.value == "s") || (player_hand.value  == "s" && computer_hand.value == "p")
      puts "You Won!"
      @@wins += 1
    elsif player_hand.value == computer_hand.value
      puts "It's a Tie"
      @@ties += 1
    else
      puts "Sorry, the computer won :("
      @@losses += 1
    end
  end

  def play
    puts "Let's Play Rock Paper Scissors!!"
    ph=PlayerHand.new
    ch=ComputerHand.new
    evaluate_game(ph,ch)
    @@games_played += 1
  end

  def play_again?
    puts "Play again? Y for Yes, anything else for No"
    input=gets.chomp.downcase
    return input == "y" ? true : false
  end

  def multi_play
    go = true
    until !go
      play
      go = play_again?
    end
  end

end

g = Game.new.multi_play
puts "You Played #{Game.games_played} Games"
puts "You Won #{Game.wins} Games"



