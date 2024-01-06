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
    first_player_symbol = "\u{25CF}".blue
    second_player_symbol = "\u{25CF}".red
    describe "#move_processes" do
      subject(:board){ described_class.new }
      context "When grid is all empty and user is trying to drop a circle to specific cell" do
      
      it "replaces white circle with player's specific circle color" do
        board.move_processes(0,0)
        board_cell = board.instance_variable_get(:@grid)
        expect(board_cell[0][0]).to eq(first_player_symbol)
      end
    end
    context "When grid is all empty and move status is false and player moves" do
    
      it "it drops a circle to specified cell" do
        board.move_processes(0,1)
        board_cell = board.instance_variable_get(:@grid)
        expect(board_cell[0][1]).to eq(first_player_symbol)
      end
      xit 'changes move_status to true' do
        expect{ board.move_processes(0,1) }.to change { board.instance_variable_get(:@move_status) }.from(false).to(true)
      end
    end
    context "When grid is all empty and move status is true and player moves" do
     before do
      board.instance_variable_set(:@move_status, true)

     end
      it "it drops a circle to specified cell" do
        board.move_processes(0,2)
        board_cell = board.instance_variable_get(:@grid)
        expect(board_cell[0][2]).to eq(second_player_symbol)
      end
      xit "changes move_status to false" do
        board.instance_variable_set(:@move_status, true)
        expect{ board.move_processes(0,2) }.to change { board.instance_variable_get(:@move_status) }.from(true).to(false)
      end
    end
    context "When grid has one filled cell in specific column and move status is true and user is trying to drop a circle to the same column" do
      before do
      
        board.instance_variable_set(:@move_status, true)
        change_grid = board.instance_variable_get(:@grid)
        change_grid[0][0] = first_player_symbol
        board.instance_variable_set(:@grid, change_grid)
      end
      it "drops a circle upon another circle" do
        board.move_processes(1,0)
      board_cell = board.instance_variable_get(:@grid)
      expect(board_cell[1][0]).to eq(second_player_symbol)
      end
    end
  end

  describe "#input_validation" do
  subject(:board_input){ described_class.new }
  context "When user is trying to select full column and then inputs correct value" do
    before do
      changed_grid = board_input.instance_variable_get(:@grid)
      i = 0
      6.times do
        changed_grid[i][0] = first_player_symbol
        i+=1
      end
      board_input.instance_variable_set(:@grid, changed_grid)
    end
    it "throws an error message once and complete iteration" do
      error_message = 'This column is already full!'
      expect(board_input).to receive(:puts).with(error_message).once
      board_input.input_validation(1)
    end
  end
end

describe "#column_full?" do
subject(:board){ described_class.new }
context "When column is full" do
  before do
    changed_grid = board.instance_variable_get(:@grid)
    i = 0
    6.times do
      changed_grid[i][0] = first_player_symbol
      i+=1
      end
    board.instance_variable_set(:@grid, changed_grid)
    end
  it "returns true" do
    column = 0
    result = board.column_full?(column)
    expect(result).to eq(true)
  end
  end
  context "When column isn't full" do
    before do
      changed_grid = board.instance_variable_get(:@grid)
      i = 0
      5.times do
        changed_grid[i][0] = first_player_symbol
        i+=1
        end
        board.instance_variable_set(:@grid, changed_grid)
      end
      it "returns false" do
      column = 0
      result = board.column_full?(column)
      expect(result).to eq(false)
    end
  end
end

  describe "#enter_input" do
  subject(:board){ described_class.new }
  context "When user inputs digit between 1-6" do
    before do 
      allow(board).to receive(:puts)
      allow(board).to receive(:gets).and_return('5')

    end
    it "sends message to column full?" do
      expect(board).to receive(:input_validation).with(5).and_return(4)
      board.enter_input
    end
  end
  context "When user inputs incorrect digit and correct" do
    before do 
      allow(board).to receive(:puts)
      allow(board).to receive(:gets).and_return('7','6')

    end
    error_message = "Input should only be between 1-6!"
    it "outputs error_message once and then sends message to column full?" do
      expect(board).to receive(:puts).with(error_message).once
      expect(board).to receive(:input_validation).with(6).and_return(5)
      board.enter_input
    end
  end
end

  describe "#check_horizontal" do
  subject(:board){ described_class.new }
  context "When win combination placed horizontal in first row on [1,2,3,4] columns" do
    before do
      board.instance_variable_set(:@last_visited, [0,3])
      changed_grid = board.instance_variable_get(:@grid)
      i = 0
      4.times do
        changed_grid[0][i] = first_player_symbol
        i+=1
        end
        board.instance_variable_set(:@grid, changed_grid)
    end
    it 'returns true' do
    expect(board.check_horizontal).to be(true)
    end
  end
  context "When win combination placed in second row on [2,3,4,5] columns" do
    before do
      board.instance_variable_set(:@last_visited, [1,1])
      changed_grid = board.instance_variable_get(:@grid)
      i = 0
      4.times do
        changed_grid[1][i] = first_player_symbol
        i+=1
        end
        board.instance_variable_set(:@grid, changed_grid)
    end
    it 'returns true' do
      expect(board.check_horizontal).to be(true)
    end
  end
  context "When combination isn't completed yet" do 
    before do
      board.instance_variable_set(:@last_visited, [0,0])
      changed_grid = board.instance_variable_get(:@grid)
      i = 0
      3.times do
        changed_grid[0][i] = first_player_symbol
        i+=1
        end
        board.instance_variable_set(:@grid, changed_grid)
    end
    it "returns false" do
      expect(board.check_horizontal).to be(false)
    end
  end
end

  describe "#check_vertical" do
  subject(:board){ described_class.new }
  context "When win combination placed vertical" do
    before do
      board.instance_variable_set(:@last_visited, [0,0])
      changed_grid = board.instance_variable_get(:@grid)
      i = 0
      4.times do
        changed_grid[i][0] = first_player_symbol
        i+=1
        end
        board.instance_variable_set(:@grid, changed_grid)
    end
    it "returns true" do
      expect(board.check_vertical).to be(true)

    end
  end
end

  describe "#check_horizontal" do
  subject(:@board){ described_class.new }
  context "When win combination is placed horizontal" do
    
  end
end

end