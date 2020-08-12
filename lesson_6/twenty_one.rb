require 'yaml'

MESSAGES = YAML.load_file('twenty_one_messages.yml')
SUIT_CARDS = 'KQJA23456789'
DEALER = 'Dealer'
PLAYER = 'Player'
DELAY = 1
DEALER_THRESHOLD = 17
BUST_VALUE = 21
GAME_WIN_CONDITION = 5
NUMBER_WORDS =
  { 0 => [],
    1 => ['One', 'Ten'], 2 => ['Two', 'Twenty'], 3 => ['Three', 'Thirty'],
    4 => ['Four', 'Forty'], 5 => ['Five', 'Fifty'], 6 => ['Six', 'Sixty'],
    7 => ['Seven', 'Seventy'], 8 => ['Eight', 'Eighty'], 9 => ['Nine', 'Ninty'],
    11 => 'Eleven', 12 => 'Twelve', 13 => 'Thirteen',
    14 => 'Fourteen', 15 => 'Fifteen', 16 => 'Sixteen',
    17 => 'Seventeen', 18 => 'Eighteen', 19 => 'Nineteen',
    100 => 'Hundred', 1000 => 'Thousand' }

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

# rubocop:disable Metrics/AbcSize
def number_to_word_array(integer)
  int_array = integer.digits

  int_array.map.with_index do |digit, index|
    case index
    when 0
      NUMBER_WORDS[digit][index] unless int_array[1] == 1
    when 1
      if (11..19).cover?(integer % 100)
        NUMBER_WORDS[10 + int_array[0]]
      else
        NUMBER_WORDS[digit][index]
      end
    when 2..3
      NUMBER_WORDS[digit][0] + ' ' + NUMBER_WORDS[10**index]
    end
  end.reverse
end
# rubocop:enable Metrics/AbcSize

def number_to_words(integer)
  # Can only handle up to thousandths digit
  return integer if integer.digits.size > 4

  word_digits = number_to_word_array(integer)

  # hyphenate tens and ones digit words
  if !word_digits[-2, 2].any?(nil)
    word_digits[-2, 2] = word_digits[-2, 2].join('-')
  end

  word_digits.compact.join(' ')
end

def initialize_deck
  # Opt for not tracking suits as not important to function of game
  deck = SUIT_CARDS.chars * 4
  deck.shuffle
end

def initialize_game_hash(default_value)
  { PLAYER => default_value.dup, DEALER => default_value.dup }
end

def deal_cards!(deck, hands, sums, owner = nil, num_cards = 2)
  if owner.nil? # deal to everyone
    hands.each do |_, hand|
      deck.pop(num_cards).each { |card| hand << card }
    end
  else # deal to specific person
    deck.pop(num_cards).each { |card| hands[owner] << card }
  end

  update_sums!(sums, hands)
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
  when 'A'           then 1 # in practice, this won't actually be used
  else               card.to_i
  end
end

def user_choose_move
  answer = ''
  loop do
    prompt MESSAGES['choose_move']
    answer = gets.chomp.downcase
    break if %w(hit stay h s).include?(answer)
    prompt MESSAGES['invalid_choice']
  end
  answer
end

def cards_sum(hand)
  sum = 0
  count_ace = 0

  hand.each do |card|
    if card == 'A'
      count_ace += 1 # track number of Aces but don't add to sum yet
    else
      sum += card_value(card)
    end
  end

  count_ace.times do
    sum += (sum > BUST_VALUE - 11 ? 1 : 11)
  end

  sum
end

def update_sums!(sums, hands)
  hands.each do |owner, hand|
    sums[owner] = cards_sum(hand)
  end
end

def update_scores!(scores, winning_player)
  scores[winning_player] += 1
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

def switch_player_turn(name)
  case name
  when PLAYER then DEALER
  when DEALER then PLAYER
  end
end

def play_again?
  answer = ''
  puts MESSAGES['line']
  sleep DELAY + 0.5

  loop do
    prompt MESSAGES['play_again']
    answer = gets.chomp.downcase
    break if %w(yes no y n).include?(answer)
    prompt MESSAGES['invalid_choice']
  end
  %w(y yes).include?(answer)
end

def dealer_turn!(deck, hands, sums)
  display_turn_start(DEALER)

  loop do
    display_cards(hands, sums, DEALER)
    break if any_bust?(sums)                   # check for bust

    sleep DELAY
    if sums[DEALER] < DEALER_THRESHOLD         # hit
      puts format(MESSAGES['hit'], DEALER)

      deal_cards!(deck, hands, sums, DEALER, 1)
    else                                       # stay
      puts format(MESSAGES['stay'], DEALER)
      break
    end
  end
end

def player_turn!(deck, hands, sums)
  loop do
    if hands[PLAYER].size > 2
      system 'clear'
      display_welcome_message(deck)
    else
      sleep DELAY
    end

    display_turn_start(PLAYER)

    display_cards(hands, sums, DEALER, true)
    display_cards(hands, sums, PLAYER)

    break if %w(stay s).include?(user_choose_move) # stay

    deal_cards!(deck, hands, sums, PLAYER, 1)      # hit

    display_cards(hands, sums, PLAYER)
    break if any_bust?(sums)                       # check for bust
  end
end

def both_players_play!(deck, hands, sums)
  current_player = PLAYER

  2.times do
    case current_player
    when PLAYER
      player_turn!(deck, hands, sums)
      current_player = switch_player_turn(current_player)
    when DEALER
      dealer_turn!(deck, hands, sums)
    end

    break if any_bust?(sums)
  end
end

def display_cards(hands, sums, owner, hide_last_card = false)
  cards = hands[owner].map { |card| card_name(card) }
  if hide_last_card
    prompt format(MESSAGES['show_hand_hidden'], owner, cards[0])
  else
    prompt format(MESSAGES['show_hand'],\
                  owner, join_and(cards), sums[owner])
  end
end

def display_sum(sums)
  message =
    sums.map do |owner, sum|
      format(MESSAGES['sums'], owner, sum)
    end

  puts MESSAGES['line']
  sleep DELAY
  prompt join_and(message)
end

def display_welcome_message(deck)
  puts format(MESSAGES['lets_play'], number_to_words(BUST_VALUE))

  display_all_instructions if deck.nil?

  puts MESSAGES['line']
end

def display_all_instructions
  puts format(MESSAGES['round_instructions'], BUST_VALUE, BUST_VALUE)
  puts format(MESSAGES['game_instructions'], GAME_WIN_CONDITION)
end

def display_turn_start(owner)
  puts format(MESSAGES['turn'], owner)
end

def display_scores(scores)
  message = scores.map { |owner, score| "#{owner}: #{score}" }

  puts MESSAGES['line']
  prompt MESSAGES['score'] + join_and(message)
end

def display_bust_message(busted_player)
  prompt format(MESSAGES['bust'], busted_player)
end

def display_win_message(winning_player)
  prompt format(MESSAGES['win'], winning_player)
end

def display_tie_message
  prompt MESSAGES['tie']
end

def display_game_win_message(scores)
  prompt format(MESSAGES['game_win'],\
                scores.key(GAME_WIN_CONDITION), GAME_WIN_CONDITION)
end

def display_thank_you_message
  prompt MESSAGES['thanks']
end

# Game Start
score_board = initialize_game_hash(0)
game_deck = nil

# Round Start
loop do
  # Set up
  system 'clear'
  display_welcome_message(game_deck)

  game_deck = initialize_deck
  game_hands = initialize_game_hash([])
  hand_sums = initialize_game_hash(0)

  deal_cards!(game_deck, game_hands, hand_sums)

  # Turns
  both_players_play!(game_deck, game_hands, hand_sums)

  # Outcome
  display_sum(hand_sums)

  display_bust_message(who_busted(hand_sums)) if any_bust?(hand_sums)

  winner = who_won(hand_sums)
  if !!winner
    update_scores!(score_board, winner)
    display_win_message(winner)
  else
    display_tie_message
  end

  display_scores(score_board)

  # Check for game winner
  if score_board.value?(GAME_WIN_CONDITION)
    display_game_win_message(score_board)
    score_board = initialize_game_hash(0)
  end

  break unless play_again?
end

display_thank_you_message
