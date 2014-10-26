# Paper rock scissors game
require 'pry'

puts "Let's play paper rock scissors!"

def get_player_choice
	input=""
	until input =="p" || input =="r" || input =="s" do 
		puts "Please enter P, R or S"
		input=gets.chomp.downcase
	end 
	return input
end

def get_computer_choice
	choices = ["p","r","s"]
	choices.sample
end

def play_again?
	puts "Play again? Y for Yes, anything else for No"
	input=gets.chomp.downcase
	input == "y" ? true : false
end

def evaluate_game(player, computer, scores)
	choices_hash = {"p"=>"Paper","r"=>"Rock","s"=>"Scissors"}
	puts "You chose #{choices_hash[player]}"
	puts "The computer chose #{choices_hash[computer]}"
	if (player == "p" && computer == "r") || (player == "r" && computer == "s") || (player == "s" && computer == "p")
		puts "You Won!"
		scores[:wins]+=1
	elsif player == computer
		puts "It's a Tie"
		scores[:ties]+=1
	else
		puts "Sorry, the computer won :("
		scores[:losses]+=1
	end
end

play=true
scores={wins:0,losses:0,ties:0}

while play
	player = get_player_choice
	computer = get_computer_choice
	evaluate_game(player, computer, scores)
	play=play_again?
end

#summary statistics
puts "You played #{scores[:wins]+scores[:losses]+scores[:ties]} games"
puts "#{scores[:wins]} Wins"
puts "#{scores[:losses]} Losses"
puts "#{scores[:ties]} Ties"


