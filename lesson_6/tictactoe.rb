require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
PLAYER_NAME = 'Player'
COMPUTER_NAME = 'Computer'
WINNING_LINES =
  [[1, 2, 3], [4, 5, 6], [7, 8, 9],
   [1, 4, 7], [2, 5, 8], [3, 6, 9],
   [1, 5, 9], [3, 5, 7]]
# COMPUTER_NAME, PLAYER_NAME, 'choose', 'random', 'alternating'
WHO_GOES_FIRST = 'random'
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
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice"
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
  "The current score is: "\
  "#{PLAYER_NAME}: #{scrs[PLAYER_NAME]} "\
  "#{COMPUTER_NAME}: #{scrs[COMPUTER_NAME]}"
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
    prompt 'Play again? (y or n)'
    answer = gets.chomp.downcase
    break if ('yn').include?(answer)
    prompt "Sorry, that's not a valid choice"
  end
  answer == 'y'
end

def choose_first_player
  answer = ''
  loop do
    prompt "Who will go first? (#{PLAYER_NAME} or #{COMPUTER_NAME})"
    answer = gets.chomp.capitalize
    break if answer == PLAYER_NAME || answer == COMPUTER_NAME
    prompt "Sorry, that's not a valid choice"
  end
  answer
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
  first_player =
    case WHO_GOES_FIRST
    when PLAYER_NAME, COMPUTER_NAME
      WHO_GOES_FIRST
    when 'choose'
      choose_first_player
    when 'random'
      [PLAYER_NAME, COMPUTER_NAME].sample
    when 'alternating'
      game_iterations.even? ? PLAYER_NAME : COMPUTER_NAME
    else
      PLAYER_NAME
    end

  current_player = first_player

  # Turns
  loop do
    display_board(board)
    prompt current_score(scores)
    if board.values.count(INITIAL_MARKER) > 7
      prompt "#{first_player} goes first!"
    end
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)

    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    winner = detect_winner(board)
    keep_score!(scores, winner)
    prompt "#{winner} won!"
  else
    prompt "It's a tie!"
  end

  prompt current_score(scores)

  if game_won?(scores)
    prompt "#{detect_game_winner(scores)} is the first to 5 wins. "\
           "They win the game!"

    scores = initialize_scores
  end

  game_iterations += 1
  break unless play_again?
end

prompt 'Thanks for playing Tic Tac Toe!  Good bye!'
