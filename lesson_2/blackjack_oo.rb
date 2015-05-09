# OO Blackjack

class Card
  attr_reader :suit, :value
  def initialize(suit,value)
    @suit = suit
    @value = value
  end

  def pretty_output
    "The #{value} of #{suit}"
  end

  def to_s
    pretty_output
  end
end


class Deck
  CARD_VALUES=[2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"]
  SUITS =["Hearts", "Diamonds", "Spades", "Clubs"]

  attr_accessor :cards

  def initialize
    @cards = []
    SUITS.product(CARD_VALUES).each{|suit,value| @cards << Card.new(suit,value)}
  end

  def shuffle!
    cards.shuffle!
  end

  def deal_card
    cards.pop
  end

end

module Hand
  def show_hand
    puts "#{name}'s hand"
    cards.each do |card|
      puts "=> #{card}"
    end
    totals = calculate_totals
    if totals.length == 1 || totals.max > 21
      puts "Current Hand Value is: #{totals.min} \n\n"
    elsif totals.max == 21
      puts "Current Hand Value is: BLACKJACK!! \n\n"
    else
      puts "Current Hand Value is: #{totals.min} or #{totals.max} \n\n"
    end
  end

  def calculate_totals
    total=0
    aces=0
    totals=[]
    # Take care of Aces Last
    cards.each do |c|
      if c.value.is_a? Integer
        total+=c.value
      elsif c.value != "A" 
        total+=10
      else
        aces+=1
      end
    end

    # potential values for combinations of aces 
    # 1: 1 or 11, 2: 2 or 12, 3: 3 or 13, 4: 4 or 14
    if aces>0
      totals<<total+aces
      totals<<total+10+aces
    else
      totals<<total
    end
    totals.sort!
  end

  def get_card(new_card)
    cards << new_card
  end

  def busted?
    calculate_totals.min > 21
  end

  def final_total
    totals=calculate_totals
    if totals.max > 21
      totals.min
    else
      totals.max
    end
  end

  def show_final_hand
    puts "#{name}'s final hand"
    cards.each do |card|
      puts "=> #{card}"
    end
    puts "Final Hand Value is: #{final_total} \n\n"
  end

end

class Player 
  include Hand

  attr_accessor :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end
end

class Dealer 
  include Hand

  attr_accessor :name, :cards

  def initialize
    @name = "Dealer"
    @cards = []
  end

  def show_first_card
    puts "#{name} is showing:"
    puts "=> #{cards[0]}"
    card=cards[0]
    if card.value == 'A'
      puts "Current Hand Value is 1 or 11 \n\n"
    elsif card.value.is_a? Integer
      puts "Current Hand Value is: #{card.value} \n\n"
    else
      puts "Current Hand Value is: 10 \n\n"
    end
  end

end

#all the logic for the game 
class Game
  BLACKJACK = 21
  DEALER_STAY = 17
  attr_accessor :player, :deck, :dealer

  def initialize
    @player = Player.new("Player")
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def welcome_message
    system 'clear'
    puts "---------------------------"
    puts "Welcome to Blackjack"
    puts "Good Luck!"
    puts "---------------------------"
    puts "Press the return key to continue"
    gets.chomp
  end

  def get_player_name
    system "clear"
    puts "What is your name?"
    name = gets.chomp
    system "clear"
    name
  end
  
  def initial_deal
    deck.shuffle!
    player.get_card(deck.deal_card)
    dealer.get_card(deck.deal_card)
    player.get_card(deck.deal_card)
    dealer.get_card(deck.deal_card)
  end

  def initial_show
    player.show_hand
    dealer.show_first_card
  end

  def get_player_input
    input = ""
    until input == "hit" || input == "stay"
      puts "Do you want to hit or stay? Please type hit or stay"
      input=gets.chomp.downcase
    end 
    input
  end

  def reveal_card
    card = deck.deal_card
    puts "The revealed card is #{card} \n\n"
    sleep(2)
    card
  end

  def player_action
    action = get_player_input
    if action == "hit"
      card = reveal_card
      player.get_card(card)
    end
    player.show_hand
    action
  end

  def dealer_action
    dealer.show_hand
    puts "The Dealer draws another card...\n\n"
    card = reveal_card
    dealer.get_card(card)
    sleep(2)
  end

  def determine_outcome
    if player.busted?
      busted_message
    elsif dealer.busted?
      dealer_busted_message
    elsif player.final_total > dealer.final_total
      winning_message
    elsif dealer.final_total > player.final_total
      losing_message
    else
      tie_message
    end
  end

  def dramatic_pause
    system 'clear'
    puts "-------Your Final Cards-------"
    player.show_final_hand
    puts "-------Dealer Final Cards-------"
    dealer.show_final_hand
    puts "................."
    sleep(2)
  end

  def winning_message
    puts "The Dealer has #{dealer.final_total} and you have #{player.final_total} ... You win :)"
  end

  def dealer_busted_message
    puts "The Dealer busted and you had #{player.final_total}! You Win!"
  end

  def busted_message
    puts "Sorry, You busted! You Lose :("
  end

  def losing_message
    puts "The Dealer has #{dealer.final_total} and you only had #{player.final_total} ... you lose :("
  end

  def tie_message
    puts "The Dealer has #{dealer.final_total} and you also have #{player.final_total} ... it's a tie"
  end

  def play
    welcome_message
    player.name = get_player_name

    initial_deal
    initial_show
  
    action=""

    until player.busted? || player.calculate_totals.include?(BLACKJACK) || action == "stay"
      action = player_action
    end 
    
    until dealer.busted? || player.busted? || dealer.final_total >= DEALER_STAY || dealer.calculate_totals.include?(BLACKJACK)
      dealer_action
    end 

    dramatic_pause
    determine_outcome
  end
end

Game.new.play
