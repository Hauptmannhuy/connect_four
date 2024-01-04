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

  describe "#move_announcment" do
  subject(:game_announcment){ described_class.new }
  context "When move status is false" do
    it "promts first player to make his move" do
      result = game_announcment.move_announcment(false)
        expect(result).to eq("It's first player turn!")
  
    end
  end
end


end

describe Player do

  describe "#set_name" do
  subject(:player){ described_class.new }
    context "When no player is specified" do
      before do
        allow(player).to receive(:gets).and_return('Player1')
      end
      it "changes instance variable name from nil to user input" do
        expect{ player.set_name }.to change { player.instance_variable_get(:@name) }.from(nil).to('Player1')
      end
    end
    context "When player 1 is specified and user trying to input duplicate name and then correct name" do
      before do
        Player.class_variable_get(:@@taken_names) << 'Player1'
        allow(player).to receive(:gets).and_return('Player1','Player2')
      end
      it "throws an error message once and then passes iteration" do
        error_message = 'You cannot choose name of the first player!'
        expect(player).to receive(:puts).with(error_message).once
        player.set_name
      end
    end
    end
  end


  describe Board do
    describe "#player_move" do
      subject(:board){ described_class.new }
      context "When grid is all empty and user is trying to drop a circle to specific cell" do
        before do
          allow(board).to receive(:gets).and_return('1')
        end
      it "replaces white circle with player's specific circle color" do
        board.player_move
        board_cell = board.instance_variable_get(:@grid)
        expect(board_cell[0][0]).to eq('0')
      end
    end
    context "When grid is all empty and move status is false and player moves once" do
      before do
        allow(board).to receive(:gets).and_return('2')
      end
      it "it drops a circle to specific cell" do
        board.player_move
        board_cell = board.instance_variable_get(:@grid)
        expect(board_cell[0][1]).to eq('0')
      end
      it 'changes move_status to true' do
        expect{ board.player_move }.to change {  board.instance_variable_get(:@move_status) }.from(false).to(true)
      end
    end
  end
  end
