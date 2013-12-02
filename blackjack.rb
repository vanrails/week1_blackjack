# Blackjack version 1 - ugly

def get_value(hand)
	value = 0
	no_ace_hand = hand.dup
	aces_count = 0

	# extract the aces to handle later
	no_ace_hand.delete_if do |card| 
		if card[1] == 'Ace'
			aces_count += 1
			true
		end
	end

	no_ace_hand.each do |card|
		if card[1].to_i == 0
			value += 10
		else
			value += card[1].to_i
		end
	end

	aces_count.times do
		if value + 11 > 21
			value += 1
		else
			value += 11
		end
	end
	value 
end

def create_deck
	suits = %w(Hearts Diamonds Spades Clubs)
	cards = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
	deck = []
	5.times do # using 5 decks
		deck += suits.product(cards)
	end
	deck
end

puts "What is your name?"
player_name = gets.chomp
puts

while true
	player_hand = []
	dealer_hand = []
	game_over = false
	deck = create_deck
	deck.shuffle!

	player_hand << deck.pop
	dealer_hand << deck.pop
	player_hand << deck.pop
	dealer_hand << deck.pop

	player_value = get_value(player_hand)
	dealer_value = get_value(dealer_hand)

	puts "\n\n\n\n"
	puts "Dealer has: #{dealer_hand} with a value of #{dealer_value}"
	puts "#{player_name}, you have: #{player_hand} with a value of #{player_value}" 

	while true
		puts " => Hit or Stand"
		action = gets.chomp
		if action.downcase == 'hit'
			player_hand << deck.pop
			player_value = get_value(player_hand)
			puts "#{player_name}, you have #{player_hand} with a value of #{player_value}"
			if player_value > 21
				puts
				puts "#{player_name}, you are BUST"
				game_over = true	
				break
			end
		elsif action.downcase == 'stand'
			break
		end
	end

	if game_over == true
		next
	end

	while true
		dealer_value = get_value(dealer_hand)
		if dealer_value > 21
			puts "Dealer has: #{dealer_hand} with a value of #{dealer_value}"
			puts
			puts "#{player_name}, the dealer went bust, you WIN!"
			game_over = true
			break
		elsif dealer_value < 17
			dealer_hand << deck.pop
		else
			break
		end
	end

	if game_over == true
		next
	end

	puts "Dealer has: #{dealer_hand} with a value of #{dealer_value}"

	if player_value > dealer_value
		puts
		puts "#{player_name}, you WIN!"
	elsif dealer_value > player_value
		puts
		puts "Dealer wins"
	else
		puts
		puts "It's a DRAW"
	end
end