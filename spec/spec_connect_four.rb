require_relative '../lib/game.rb'

describe Game do 
  describe "#initialize" do
  subject(:game_init){ described_class.new }
  
  context "When initializing new instance of Game" do
  
    it 'creates new instance of Player in player attribute' do
      player_attribute = game_init.instance_variable_get(:@player_1)
      expect(player_attribute).to be_an_instance_of(Player)
    end
    it 'creates new instance of Board class in board attribute' do
      board_attribute = game_init.instance_variable_get(:@board)
      expect(board_attribute).to be_an_instance_of(Board)
    end
  end
end

  describe "#set_players" do
  subject(:game_set){ described_class.new }

  context "When it's called" do
    it "Sends message to setup_player twice" do
     player_instance_1 = game_set.instance_variable_get(:@player_1)
     player_instance_2 = game_set.instance_variable_get(:@player_2)
      expect(player_instance_1).to receive(:setup_player).once
      expect(player_instance_2).to receive(:setup_player).once
      game_set.set_players
    end
  end
end
  
end


# 1. Initialize class Player that has name and color-marker attribute
# 2. Initialize Game class that has core logic of the game
# 3. Initialize Board class that creating board and change it cells in process of the game

# 1.1 When initializing 
