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
    it "Sends message to #greetings twice" do
      expect(game_set).to receive(:greetings).twice
      game_set.set_players
    end
  end
end

  describe "#greetings" do
  subject(:game_greeting){ described_class.new }
  context "When it's called" do
    it "sends message to #setup_player once" do
    player_instance = game_greeting.instance_variable_get(:@player_1)
    expect(player_instance).to receive(:setup_player).once
    game_greeting.greetings(player_instance)
    end
  end
  end

  describe "#greeting_player" do
    subject(:game_greeting){ described_class.new }
  context "When no player specifed" do
    it 'greets first player and asks for his name' do
      greeting = 'Hello, player 1, type your name.'
      expect(game_greeting).to receive(:puts).with(greeting)
      game_greeting.greeting_player
    end
  end
end
  
end

describe Player do

  describe "#set_name" do
  subject(:player){ described_class.new }
  
    end
  end



# 1. Initialize class Player that has name and color-marker attribute
# 2. Initialize Game class that has core logic of the game
# 3. Initialize Board class that creating board and change it cells in process of the game

# 1.1 When initializing 
