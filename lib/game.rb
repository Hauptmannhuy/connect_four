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
   player_1.setup_player
   player_2.setup_player
  end
end
