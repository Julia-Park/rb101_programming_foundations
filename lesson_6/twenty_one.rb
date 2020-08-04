require 'yaml'
require 'pry'

MESSAGES = YAML.load_file('twenty_one_messages.yml')
SUIT_CARDS = 'KQJA23456789'
DEALER = 'Dealer'
PLAYER = 'Player'
DEALER_THRESHOLD = 17
BUST_VALUE = 21
GAME_WIN_CONDITION = 5

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

def initialize_game_hash(default_value)
  { PLAYER => default_value.dup, DEALER => default_value.dup }
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

def list_cards(hands, sums, owner, hide_last_card = false)
  cards = hands[owner].map { |card| card_name(card) }
  if hide_last_card
    prompt format(MESSAGES['show_hand_hidden'], owner, cards[0])
  else
    prompt format(MESSAGES['show_hand'],\
                  owner, join_and(cards), sums[owner])
  end
end

def list_sums(sums)
  message =
    sums.map do |owner, sum|
      format(MESSAGES['sums'], owner, sum)
    end

  prompt join_and(message)
end

def list_score(scores)
  message =
    scores.map do |owner, score|
      "#{owner}: #{score}"
    end

  prompt MESSAGES['score'] + join_and(message)
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

def update_sums!(sums, hands)
  hands.each do |owner, hand|
    sums[owner] = card_sum(hand)
  end
end

def any_bust?(sums)
  sums.any? { |_, sum| bust?(sum) }
end

def bust?(sum)
  sum > BUST_VALUE
end

def who_busted(sums)
  busted = sums.select { |_, sum| bust?(sum) }.keys
  busted[0]
end

def who_won(sums)
  max_sum = sums.values.select { |sum| !bust?(sum) }.max
  winner = sums.select { |_, sum| sum == max_sum }.keys
  winner.size == 1 ? winner[0] : nil
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
score_board = initialize_game_hash(0)

# Round Start
loop do
  # Set up
  system 'clear'
  game_deck = initialize_deck
  game_hands = initialize_game_hash([])
  hand_sums = initialize_game_hash(0)

  deal_cards!(game_deck, game_hands[PLAYER])
  deal_cards!(game_deck, game_hands[DEALER])
  update_sums!(hand_sums, game_hands)

  current_player = PLAYER

  # Turns
  2.times do
    case current_player
    when PLAYER # Player turn
      loop do
        system 'clear' if game_hands[PLAYER].size > 2
        puts MESSAGES['lets_play']
        puts MESSAGES['line']
        puts format(MESSAGES['turn'], PLAYER)

        list_cards(game_hands, hand_sums, DEALER, true)
        list_cards(game_hands, hand_sums, PLAYER)

        answer = choose_move
        break if %w(stay s).include?(answer)            # stay

        deal_cards!(game_deck, game_hands[PLAYER], 1)   # hit
        update_sums!(hand_sums, game_hands)

        list_cards(game_hands, hand_sums, PLAYER)
        break if any_bust?(hand_sums)                   # check for bust
      end
      current_player = other_player(current_player)

    when DEALER # Dealer turn
      puts MESSAGES['line']
      puts format(MESSAGES['turn'], DEALER)

      loop do
        list_cards(game_hands, hand_sums, DEALER)
        break if any_bust?(hand_sums)                   # check for bust

        if hand_sums[DEALER] < DEALER_THRESHOLD         # hit
          deal_cards!(game_deck, game_hands[DEALER], 1)
          update_sums!(hand_sums, game_hands)

          puts format(MESSAGES['hit'], DEALER)
        else                                            # stay
          puts format(MESSAGES['stay'], DEALER)
          break
        end
      end
    end

    break if any_bust?(hand_sums)
  end

  # Determine round winner
  puts MESSAGES['line']
  list_sums(hand_sums)

  prompt format(MESSAGES['bust'], who_busted(hand_sums)) if any_bust?(hand_sums)

  winner = who_won(hand_sums)
  if !!winner
    score_board[winner] += 1
    prompt format(MESSAGES['win'], winner)
  else
    prompt MESSAGES['tie']
  end

  puts MESSAGES['line']
  list_score(score_board)

  # Check for game winner
  if score_board.value?(GAME_WIN_CONDITION)
    prompt format(MESSAGES['game_win'],\
                  score_board.key(GAME_WIN_CONDITION), GAME_WIN_CONDITION)
    score_board = initialize_game_hash(0)
  end

  puts MESSAGES['line']
  break unless play_again?
end

prompt MESSAGES['thanks']
