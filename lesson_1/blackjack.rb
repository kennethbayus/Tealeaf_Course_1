# Procedural Blackjack Game

# Shuffle the deck
# Deal the player and the Dealer cards
# Tell the player what cards he is holding (A can be 1 or 11 for the total)
# Also calculate the total
# Tell the player what card the dealer is showing (only top card)
# Ask the player if he wants to hit or stay
# Repeat this until the player stays or busts (goes over 21)
# If the player stays, then the dealer draws until he has 17 or more, or busts 

def build_deck
  cards=[2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"]
	suits =["Hearts", "Diamonds", "Spades", "Clubs"]

	deck=cards.product(suits).map{ |c,s|
		{card: c, suit: s}
	}
	deck.shuffle
end

def deal_player(deck, player_cards)
	player_cards<<deck.pop
end

def deal_dealer(deck, dealer_cards)
	dealer_cards<<deck.pop
end

def calculate_total(cards)
	total=0
	aces=0
	totals=[]
	# Take care of Aces Last
	cards.each do |c|
		if c[:card].is_a? Integer
			total+=c[:card]
		elsif c[:card] == "K" || c[:card] == "Q" || c[:card] == "J" 
			total+=10
		else
			aces+=1
		end
	end
	# potential values for combinations of aces 
	# 1: 1 or 11, 2: 2 or 12, 3: 3 or 13, 4: 4 or 14
	if aces>0
		#minimum value added
		totals<<total+aces
		#maximum value added
		totals<<total+10+aces
	else
		totals<<total
	end
end

def final_total(cards)
	totals=calculate_total(cards)
	if totals.max > 21
		totals.min
	else
		totals.max
	end
end

def busted?(cards)
	calculate_total(cards).min > 21
end

def display_cards(cards)
	cards.map{|c| c[:card].to_s + "-" + c[:suit]}	
end

def get_player_input
	input=""
	until input =="hit" || input =="stay"
		puts "Do you want to hit or stay? Please type hit or stay"
		input=gets.chomp.downcase
	end 
	return input
end

def print_cards(player_cards)
	puts "You have #{display_cards(player_cards).join(",")}"

	totals=calculate_total(player_cards)

	if totals.include?(21)
		puts "You have 21 !!! ... Lets see what the dealer has"
	elsif totals.max < 21 && totals.length>1
		puts "Your total is #{totals.min} or #{totals.max}"
	else 
		puts "Your total is #{totals.min}"
	end
end

#play the game

play = true

while play
	player_cards=[]
	dealer_cards=[]
	totals=[]
	deck=build_deck
	action=""

	2.times do deal_player(deck, player_cards) end
	2.times do deal_dealer(deck, dealer_cards) end

	print_cards(player_cards)

	#show one card from the dealer
	puts "The dealer is showing #{dealer_cards[1][:card].to_s}-#{dealer_cards[1][:suit]}"

	# while not busted and not choosing to stay, do player actions
	while !busted?(player_cards)
		if calculate_total(player_cards).include?(21)
			break
		end

		action=get_player_input

		if action == "hit"
			deal_player(deck, player_cards)
			print_cards(player_cards)
		else
			print_cards(player_cards)
			break
		end
	end

	#if the player busts, the game is over
	if busted?(player_cards)
		puts "Sorry, You busted! You Lose :("
		break
	end

	#show the dealer's other card and current total
	puts "---------------------------------------------------------"
	puts "The dealer shows #{dealer_cards[0][:card].to_s}-#{dealer_cards[0][:suit]}"
	puts "The dealer has #{calculate_total(dealer_cards).max}"

	while !busted?(dealer_cards)
		if calculate_total(dealer_cards).include?(21)
			break
		end
		if calculate_total(dealer_cards).max < 17
			puts "The dealer draws cards until he has 17 or greater"
			card = deal_dealer(deck, dealer_cards).last
			puts "The dealer drew #{card[:card]}-#{card[:suit]}"
		else
			break
		end
	end

	if busted?(dealer_cards)
		puts "The dealer busted!! You Win :)"
		break
	elsif dealer_cards.length > 2 && !busted?(dealer_cards)
		puts "The dealer has #{final_total(dealer_cards)}"	
	else
	end

	#determine the winner
	#pick max value for player and dealer 
	player_final = final_total(player_cards)
	dealer_final = final_total(dealer_cards)
	if  player_final > dealer_final
	  puts "You have #{player_final} and the dealer has #{dealer_final}"
		puts "You Win :) !!"
	elsif dealer_final > player_final
		puts "You have #{player_final} and the dealer has #{dealer_final}"
		puts "You Lose :( !!"
	else
		puts "You have #{player_final} and the dealer has #{dealer_final}"
		puts "It's a tie..."
	end

	play = false

end


