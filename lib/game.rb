require_relative 'player'
require_relative 'board'

class Game
  attr_reader :player_1, :player_2, :board

  def initialize(player_1 = Player.new, player_2 = Player.new, board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def start
    set_players
    loop do
      turn_order
      board.player_move
      board.display_grid
      break if player_win? || board.is_tie?

      board.switch_status
    end
  end

  def set_players
    greetings(player_1)
    greetings(player_2)
  end

  def greetings(player)
    greeting_player
    player.set_name
  end

  def turn_order
    move_status = board.move_status
    move_announcment(move_status)
  end

  def move_announcment(move_status)
    puts move_status == false ? "It's first player turn!" : "It's second player turn!"
  end

  def greeting_player
    puts "Hello, player #{player_1.name.nil? ? '1' : '2'}, type your name."
  end

  def winner_name
    board.move_status == false ? player_1.name : player_2.name
  end

  def player_win?
    return unless board.is_win?

    puts "#{winner_name} win!"
    true
  end
end

board = Game.new
board.start
