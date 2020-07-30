require 'yaml'
require 'pry'

MESSAGES = YAML.load_file('twenty_one_messages.yml')
DEALER = 'Dealer'
PLAYER = 'Player'

def prompt(msg)
  puts ">> #{msg}"
end

def join_and(array, delimiter = ', ', last_delimiter = 'and')
  case array.size
  when 0..2
    array.join(" #{last_delimiter} ")
  else
    front_elements_joined = (array[0..-2] + [last_delimiter]).join(delimiter)
    "#{front_elements_joined} #{array[-1]}"
  end
end

def initialize_deck
  deck = 'KQJA23456789'.chars * 4
  deck.shuffle
end

def deal_cards!(deck, hand, num_cards = 2)
  deck.pop(num_cards).each { |card| hand << card }
end

def card_name(card)
  case card
  when 'K' then 'King'
  when 'Q' then 'Queen'
  when 'J' then 'Jack'
  when 'A' then 'Ace'
  else          card
  end
end

def card_value(card)
  case card
  when 'K', 'Q', 'J' then 10
  when 'A'           then 1
  else               card.to_i
  end
end

def list_cards(hand, owner, hide_last_card = false)
  cards = hand.dup
  cards[-1] = 'unknown card' if hide_last_card 
  prompt format(MESSAGES['show_hand'], owner, join_and(cards))
end

def choose_move
  answer = ''
  loop do
    prompt MESSAGES['choose_move']
    answer = gets.chomp.downcase
    break if ['hit', 'stay', 'h', 's'].include?(answer)
    prompt MESSAGES['invalid_choice']
  end
  answer
end

def card_sum(hand)
  # Ace = 11 unless sum of other cards is > 10
  # START HEREEE
  if hand.include?('A')
    # find first Ace
    hand.index('A')
    # remove an Ace

    hand.each

    sum = hand.reduce do |sum, card| 
      sum += card_value(card)
    end
    case sum
    when 1..10
      sum+=11
    else
      sum+=1
    end

  else
    hand.reduce do |sum, card| 
      sum += card_value(card)
    end
  end
end

def bust?(hand) 
  card_sum(hand) > 21
end

def win?(hand)
  card_sum(hand) == 21
end
# Game Logic Start
game_deck = initialize_deck
player_hand = []
dealer_hand = []

deal_cards!(game_deck, player_hand)
deal_cards!(game_deck, dealer_hand)

system 'clear'

list_cards(player_hand, PLAYER)
list_cards(dealer_hand, DEALER, true)

loop do # Player turn
  answer = choose_move
  break if answer == 'stay'

  deal_cards!(game_deck, player_hand, 1)
  list_cards(player_hand, PLAYER)
end

# 3. Player turn - choose between hit and stay
#   - Repeat until bust or stay
#     - If bust, round over.  Dealer wins.
# 4. Dealer turn - choose between hit (if sum < 17) and stay
#   - Repeat until bust or stay
#   - If bust, round over.  Player wins.
# 5. Determine winner
#   - Dealer/Player with highest sum wins.