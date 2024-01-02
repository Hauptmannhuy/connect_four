require_relative 'player'
require_relative 'board'

class Game
  attr_reader :player_1, :player_2, :board

  def initialize(player_1 = Player.new, player_2 = Player.new, board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def set_players
   greetings(player_1)
   greetings(player_2)
  end

  def greetings(player)
    greeting_player
    player.setup_player
  end

  def greeting_player
    puts "Hello, player #{player_1.name == nil ? '1' : '2'}, type your name."
  end
end
