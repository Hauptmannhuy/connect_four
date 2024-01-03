class Player
  attr_reader :name
  @@taken_names = []
  def initialize
    @name = nil

  end

  def setup_player
    set_name
  end

  def set_name
    loop do
      input = gets.chomp
      if verify_name(input)
        @name = input
        return
      end
      puts 'You cannot choose name of the first player!'
    end
  end

  def verify_name(name)
    return name if !@@taken_names.include?(name)
  end
  
end
