#Tic Tack Toe Game

#values holds the positions on the board
values={"1"=>"", "2"=>"", "3"=>"", "4"=>"", "5"=>"", "6"=>"", "7"=>"", "8"=>"", "9"=>""}

def draw_row (arr=["1","2","3"])
	 puts "	|	|	"
	 puts "   #{arr[0]}	|   #{arr[1]}	|   #{arr[2]} "
	 puts "	|	|	" 
end

def draw_board (values)
	draw_row([values["1"],values["2"],values["3"]])
	puts "--------+-------+-------"
	draw_row([values["4"],values["5"],values["6"]])
	puts "--------+-------+-------"
	draw_row([values["7"],values["8"],values["9"]])
end

def get_player_input (values)
	input=""
	until values[input]==""
		puts "Please enter an available position using the numbers 1-9"
		input=gets.chomp
	end
	values[input]= 'X'
	return values
end

# Map returns nil values if the condition isn't met
# Used select first to solve this 
def get_computer_input(values)
	valid=values.select{|k,v| k if v==""}
	input=valid.map{|k,v| k}.sample
	values[input]='O'
	return values
end

# Check if someone wins
# 8 possible ways to get 3 in a row
def win_condition?(values)
	(((values["1"] == values["2"] && values["2"] == values["3"]) && (values["1"] == 'X' || values["1"] == 'O'))||
	((values["4"] == values["5"] && values["5"] == values["6"]) && (values["4"] == 'X' || values["4"] == 'O'))||
	((values["7"] == values["8"] && values["8"] == values["9"]) && (values["7"] == 'X' || values["7"] == 'O'))||
	((values["1"] == values["4"] && values["4"] == values["7"]) && (values["1"] == 'X' || values["1"] == 'O'))||
	((values["2"] == values["5"] && values["5"] == values["8"]) && (values["2"] == 'X' || values["2"] == 'O'))||
	((values["3"] == values["6"] && values["6"] == values["9"]) && (values["3"] == 'X' || values["3"] == 'O'))||
	((values["1"] == values["5"] && values["5"] == values["9"]) && (values["1"] == 'X' || values["1"] == 'O'))||
	((values["7"] == values["5"] && values["5"] == values["3"]) && (values["7"] == 'X' || values["7"] == 'O')))
end

# Main Game
while values.has_value?("")
	draw_board(values)
	values=get_player_input(values)
	if win_condition?(values)
		draw_board(values)
		puts "Player Wins!"
		break
	end
	values=get_computer_input(values)
	if win_condition?(values)
		draw_board(values)
		puts "Computer Wins!"
		break
	end
end

#if values is full and no winner, then we had a tie
if !values.has_value?("") && !win_condition?(values)
	draw_board(values)
	puts "It's a Tie!"
end

