require 'yaml'
require 'pry'

MESSAGES = YAML.load_file('twenty_one_messages.yml')
SUIT_CARDS = 'KQJA23456789'
DEALER = 'Dealer'
PLAYER = 'Player'
DEALER_THRESHOLD = 17
BUST_VALUE = 21

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
  deck = SUIT_CARDS.chars * 4
  deck.shuffle
end

def initialize_hands
  { PLAYER => [], DEALER => [] }
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
  when 'A'           then 1 # all Aces are 1 unless it is the first Ace
  else               card.to_i
  end
end

def list_cards(hands, owner, hide_last_card = false)
  cards = hands[owner].map { |card| card_name(card) }
  if hide_last_card
    prompt format(MESSAGES['show_hand_hidden'], owner, cards[0])
  else
    prompt format(MESSAGES['show_hand'],\
                  owner, join_and(cards), card_sum(hands[owner]))
  end
end

def list_sums(hands)
  message = []

  hands.each do |owner, hand|
    message << format(MESSAGES['totals'], owner, card_sum(hand))
  end

  prompt join_and(message)
end

def choose_move
  answer = ''
  loop do
    prompt MESSAGES['choose_move']
    answer = gets.chomp.downcase
    break if %w(hit stay h s).include?(answer)
    prompt MESSAGES['invalid_choice']
  end
  answer
end

def card_sum(hand)
  sum = 0
  first_ace_position = hand.index('A') # nil if no Ace

  hand.each.with_index do |card, index| # sum values for all except first Ace
    sum += card_value(card) unless first_ace_position == index
  end

  if !!first_ace_position # if there is a first Ace, add appropriate value
    sum += (sum > 10 ? 1 : 11) # value determined by sum of other cards
  end

  sum
end

def any_bust?(hands)
  hands.any? { |_, hand| bust?(hand) }
end

def bust?(hand)
  card_sum(hand) > BUST_VALUE
end

def who_busted(hands)
  busted = hands.select { |_, hand| bust?(hand) }.keys
  prompt format(MESSAGES['bust'], busted[0], other_player(busted[0]))
end

def who_won(hands)
  max_sum = hands.map { |_, hand| card_sum(hand) }.max
  winner = hands.select { |_, hand| card_sum(hand) == max_sum }.keys

  if winner.size == 1
    prompt format(MESSAGES['win'], winner[0])
  else
    prompt MESSAGES['tie']
  end
end

def other_player(name)
  case name
  when PLAYER then DEALER
  when DEALER then PLAYER
  end
end

def play_again?
  answer = ''
  loop do
    prompt MESSAGES['play_again']
    answer = gets.chomp.downcase
    break if %w(yes no y n).include?(answer)
    prompt MESSAGES['invalid_choice']
  end
  %w(y yes).include?(answer)
end

# Game Start
loop do
  # Set up
  game_deck = initialize_deck
  game_hands = initialize_hands

  deal_cards!(game_deck, game_hands[PLAYER])
  deal_cards!(game_deck, game_hands[DEALER])

  current_player = PLAYER

  # Turns
  2.times do
    case current_player
    when PLAYER # Player turn
      loop do
        system 'clear'

        list_cards(game_hands, DEALER, true)
        list_cards(game_hands, PLAYER)

        answer = choose_move
        break if %w(stay s).include?(answer)                # stay

        deal_cards!(game_deck, game_hands[PLAYER], 1)       # hit

        list_cards(game_hands, PLAYER)
        break if any_bust?(game_hands)                      # check for bust
      end
      current_player = other_player(current_player)

    when DEALER # Dealer turn
      loop do
        list_cards(game_hands, DEALER)
        break if any_bust?(game_hands)                      # check for bust

        if card_sum(game_hands[DEALER]) < DEALER_THRESHOLD  # hit
          deal_cards!(game_deck, game_hands[DEALER], 1)
          prompt format(MESSAGES['hit'], DEALER)
        else                                                # stay
          prompt format(MESSAGES['stay'], DEALER)
          break
        end
      end
    end

    puts ''
    break if any_bust?(game_hands)
  end

  # Determine winner
  if any_bust?(game_hands)
    who_busted(game_hands)
  else
    list_sums(game_hands)
    who_won(game_hands)
  end

  break unless play_again?
end

puts ''
prompt MESSAGES['thanks']
