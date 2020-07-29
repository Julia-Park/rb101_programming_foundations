require 'pry'
require 'yaml'

MESSAGES = YAML.load_file('tictactoe_messages.yml')
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
PLAYER_NAME = 'Player'
COMPUTER_NAME = 'Computer'
WINNING_LINES =
  [[1, 2, 3], [4, 5, 6], [7, 8, 9],
   [1, 4, 7], [2, 5, 8], [3, 6, 9],
   [1, 5, 9], [3, 5, 7]]
WHO_GOES_FIRST = 'choose'
# COMPUTER_NAME, PLAYER_NAME, 'choose', 'random', 'alternating'
GAME_WINNING_CONDITION = 5

def prompt(msg)
  puts ">> #{msg}"
end

def joinor(array, separator = ', ', last_separator = 'or')
  case array.size
  when 0..2
    array.join(" #{last_separator} ")
  else
    front_elements_joined = (array[0..-2] + [last_separator]).join(separator)
    "#{front_elements_joined} #{array[-1]}"
  end
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You are #{PLAYER_MARKER}.  #{COMPUTER_NAME} is #{COMPUTER_MARKER}."
  puts ''
  puts '     |     |     '
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts '     |     |     '
  puts '-----+-----+-----'
  puts '     |     |     '
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts '     |     |     '
  puts '-----+-----+-----'
  puts '     |     |     '
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts '     |     |     '
  puts ''
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt format(MESSAGES['choose_square'], joinor(empty_squares(brd)))
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt MESSAGES['invalid_choice']
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square =
    if almost_complete_line?(brd, COMPUTER_MARKER)  # offensive
      find_at_risk_square(brd, COMPUTER_MARKER)
    elsif almost_complete_line?(brd, PLAYER_MARKER) # defensive
      find_at_risk_square(brd, PLAYER_MARKER)
    elsif empty_squares(brd).include?(5)            # pick 5 if available
      5
    else                                            # random
      empty_squares(brd).sample
    end

  brd[square] = COMPUTER_MARKER
end

def almost_complete_line?(brd, marker)
  !!find_at_risk_square(brd, marker)
end

def find_at_risk_square(brd, marker)
  # return square which piece needs to be placed to block/complete win
  WINNING_LINES.each do |line|
    markers_in_line = line.map { |square| brd[square] }

    if markers_in_line.sort == [INITIAL_MARKER, marker, marker].sort
      return line[markers_in_line.index(INITIAL_MARKER)]
    end
  end

  nil
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    line_markers = line.map { |square| brd[square] }.uniq
    case line_markers
    when [PLAYER_MARKER]
      return PLAYER_NAME
    when [COMPUTER_MARKER]
      return COMPUTER_NAME
    end
  end

  nil
end

def someone_won?(brd)
  # use !! to turn return value of method to boolean
  !!detect_winner(brd)
end

def current_score(scrs)
  format(MESSAGES['current_score'],\
         p_name: PLAYER_NAME, p_score: scrs[PLAYER_NAME],\
         c_name: COMPUTER_NAME, c_score: scrs[COMPUTER_NAME])
end

def keep_score!(scrs, winning_player)
  # update scores
  case winning_player
  when PLAYER_NAME    then scrs[PLAYER_NAME] += 1
  when COMPUTER_NAME  then scrs[COMPUTER_NAME] += 1
  end
end

def detect_game_winner(scrs)
  scrs.key(GAME_WINNING_CONDITION)
end

def game_won?(scrs)
  !!detect_game_winner(scrs)
end

def initialize_scores
  { PLAYER_NAME => 0, COMPUTER_NAME => 0 }
end

def play_again?
  answer = ''
  loop do
    prompt MESSAGES['play_again']
    answer = gets.chomp.downcase
    break if ('yn').include?(answer)
    prompt MESSAGES['invalid_choice']
  end
  answer == 'y'
end

def player_picks_first_player
  answer = ''
  loop do
    prompt format(MESSAGES['pick_player'], PLAYER_NAME, COMPUTER_NAME)
    answer = gets.chomp.capitalize
    break if answer == PLAYER_NAME || answer == COMPUTER_NAME
    prompt MESSAGES['invalid_choice']
  end
  answer
end

def choose_first_player(iterations)
  case WHO_GOES_FIRST
  when PLAYER_NAME, COMPUTER_NAME
    WHO_GOES_FIRST
  when 'choose'
    player_picks_first_player
  when 'random'
    [PLAYER_NAME, COMPUTER_NAME].sample
  when 'alternating'
    game_iterations.even? ? PLAYER_NAME : COMPUTER_NAME
  else
    PLAYER_NAME
  end
end

def place_piece!(brd, player)
  if player == PLAYER_NAME
    player_places_piece!(brd)
  elsif player == COMPUTER_NAME
    computer_places_piece!(brd)
  end
end

def alternate_player(player)
  player == PLAYER_NAME ? COMPUTER_NAME : PLAYER_NAME
end

# Game start
scores = initialize_scores
game_iterations = 0

loop do
  board = initialize_board
  first_player = choose_first_player(game_iterations)
  current_player = first_player

  # Turns
  loop do
    display_board(board)
    prompt current_score(scores)
    if board.values.count(INITIAL_MARKER) > 7
      prompt format(MESSAGES['goes_first'], first_player)
    end
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)

    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    winner = detect_winner(board)
    keep_score!(scores, winner)
    prompt format(MESSAGES['winner'], winner)
  else
    prompt MESSAGES['tie']
  end

  prompt current_score(scores)

  if game_won?(scores)
    prompt format(MESSAGES['game_winner'], detect_game_winner(scores))

    scores = initialize_scores
  end

  game_iterations += 1
  break unless play_again?
end

prompt MESSAGES['thanks']
