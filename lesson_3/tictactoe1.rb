require 'pry'

INITIAL = " "
USER_MARKER = "X"
COMP_MARKER = "O"
WIN_ARR = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
           [1, 4, 7], [2, 5, 8], [3, 6, 9],
           [1, 5, 9], [3, 5, 7]]

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(valid_moves, separator = ", ", connector = "or")
  if valid_moves.size > 1
    "#{valid_moves[0..-2].join(separator)} #{connector} #{valid_moves[-1]}"
  else
    valid_moves[0].to_s
  end
end

def invalid_input?(input)
  if input.to_i == 0 || input.to_i > 9
    prompt("Invalid input")
    return true
  end
  false
end

def go_first?
  puts "Would you like to go first? y/n"
  answer = gets.chomp

  if answer.start_with?('y')
    "Player"
  else
    "Computer"
  end
end

def declare_result(winner)
  case winner
  when "Player"
    prompt(" You won!!!!")
  when "Computer"
    prompt(" Computer won...!")
  else
    prompt("It's a tie!")
  end
end

def someone_won?(brd)
  WIN_ARR.each do |win_arr|
    return "Player" if win_arr.all? { |value| brd[value] == USER_MARKER }
    return "Computer" if win_arr.all? { |value| brd[value] == COMP_MARKER }
  end
  false
end

# rubocop:disable Metrics/AbcSize
def display_board(brd_hsh)
  puts ""
  puts "   |   |"
  puts " #{brd_hsh[1]} | #{brd_hsh[2]} | #{brd_hsh[3]}"
  puts "   |   |"
  puts "---+---+----"
  puts "   |   |"
  puts " #{brd_hsh[4]} | #{brd_hsh[5]} | #{brd_hsh[6]}"
  puts "   |   |"
  puts "---+---+----"
  puts "   |   |"
  puts " #{brd_hsh[7]} | #{brd_hsh[8]} | #{brd_hsh[9]}"
  puts "   |   |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def intitialze_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL }
  new_board
end

# In the case where there is no threat and no defence then go for offense
# rather than a random move
def avoid_useless_move(brd, new_track_arr)
  WIN_ARR.each do |win_arr|
    if brd.values_at(*win_arr).count(" ") == 1
      dont_select = brd.values_at(*win_arr).select { |v| v == " " }
      space = new_track_arr - dont_select

      return space[0]
    end
  end
  false
end

def find_immediate_threat(brd)
  WIN_ARR.each do |win_arr|
    if brd.values_at(*win_arr).count(USER_MARKER) == 2 &&
       brd.values_at(*win_arr).any?(" ")
      hsh = brd.keys.select do |k|
        brd[k] == USER_MARKER && brd[k] != COMP_MARKER
      end
      empty_space = (win_arr - hsh)
      return empty_space[0]
    end
  end
  false
end

def find_offensive_move?(brd)
  WIN_ARR.each do |win_arr|
    if brd.values_at(*win_arr).count(COMP_MARKER) == 2 &&
       brd.values_at(*win_arr).any?(" ")
      hsh = brd.keys.select do |k|
        brd[k] == COMP_MARKER && brd[k] != USER_MARKER
      end
      empty_space = (win_arr - hsh)

      return empty_space[0]
    end
  end
  false
end

# rubocop:disable Metrics/MethodLength
def computer_input!(brd, valid_moves)
  threat = find_immediate_threat(brd)
  offense = find_offensive_move?(brd)
  useful_rand_move = avoid_useless_move(brd, valid_moves)

  if offense != false
    comp_input = offense
  elsif threat != false
    comp_input = threat
  elsif valid_moves.include?(5)
    comp_input = 5
  elsif useful_rand_move != false
    comp_input = useful_rand_move
  elsif threat == false
    comp_input = valid_moves.sample
  end

  brd[comp_input] = COMP_MARKER
  empty_spaces(comp_input, valid_moves)
end

def empty_spaces(move, valid_moves)
  valid_moves.delete_if { |index| index == move }
end

def lets_play(brd, who_goes)
  valid_moves = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  computer_input!(brd, valid_moves) if who_goes == "Computer"

  loop do
    user_input!(brd, valid_moves)
    display_board(brd)
    break if !!someone_won?(brd)

    if !valid_moves.empty?
      prompt("Computer's turn now...")
      sleep(1)
      computer_input!(brd, valid_moves)
    end
    break if !!someone_won?(brd)
    break if valid_moves.empty?
  end
end

def display_score(user_score, comp_score)
  prompt("You have won #{user_score} games")
  prompt("Computer has won #{comp_score} games")
end

def keep_score(winner, user_score, comp_score)
  if winner == "Player"
    user_score += 1
  elsif winner == "Computer"
    comp_score += 1
  end
  [user_score, comp_score]
end

def user_input!(brd, valid_moves)
  user_move = ''
  loop do
    display_board(brd)

    prompt("Your turn, enter a square from these #{joinor(valid_moves)}")
    user_move = gets.chomp

    next if invalid_input?(user_move)
    user_move = user_move.to_i

    if brd[user_move] == USER_MARKER || brd[user_move] == COMP_MARKER
      prompt("This choice is taken")
      prompt("Go again...")
      next
    else
      brd[user_move] = USER_MARKER
      break
    end
  end
  empty_spaces(user_move, valid_moves)
end
# rubocop:enable Metrics/MethodLength

def main_game
  times_played = 0
  user_score = 0
  comp_score = 0
  loop do
    board = intitialze_board
    display_board(board)
    who_goes = go_first?
    lets_play(board, who_goes)
    winner = someone_won?(board)
    display_board(board)
    declare_result(winner)
    user_score, comp_score = keep_score(winner, user_score, comp_score)
    display_score(user_score, comp_score)
    prompt("Do you want to play again? y/n")
    choice = gets.chomp
    break if choice.start_with?("n")
    times_played += 1
  end
end

main_game

prompt("Thank you for playing Tic Tac Toe!")
