require 'colorize'

class Board
  attr_reader :grid, :move_status

  def initialize
    @empty_circle = "\u{25CB}"
    @first_player_symbol = "\u{25CF}".blue
    @second_player_symbol = "\u{25CF}".red
    @grid = Array.new(6) { Array.new(7) { @empty_circle } }
    @move_status = false
  end

  def display_grid
    i = 5
    6.times do
      puts @grid[i].join
      i -= 1
    end
    puts '1234567'
  end

  def switch_status
    @move_status = @move_status == false
  end

  def player_move
    y = 0
    x = enter_input
    move_processes(y, x)
  end

  def move_processes(y, x)
    loop do
      if grid[y][x] == @empty_circle
        grid[y][x] = @move_status == false ? @first_player_symbol : @second_player_symbol
        @last_visited = [y, x]
        return
      else
        y += 1
      end
    end
  end

  def enter_input
    loop do
      puts 'Select column.'
      input = gets.chomp.to_i
      if input.between?(1, 7)
        verify_input = input_validation(input)
        return verify_input if verify_input
      else
        puts 'Input should only be between 1-7!'
      end
    end
  end

  def input_validation(input)
    input -= 1
    if !column_full?(input)
      input
    else
      puts 'This column is already full!'
    end
  end

  def column_full?(num)
    array = []
    i = 0
    6.times do
      array << @grid[i][num]
      i += 1
    end
    array.all? { |el| el != @empty_circle }
  end

  def is_win?
    check_horizontal || check_diagonal || check_vertical
  end

  def is_tie?
    @grid.each do |row|
      next if row.all? { |el| el != @empty_circle } && !is_win?

      return false
    end
    puts "It's a tie!"
    true
  end

  def check_horizontal
    y, x = @last_visited
    grid = @grid
    marker = @move_status == false ? @first_player_symbol : @second_player_symbol
    return true if grid[y][x + 1] == marker && grid[y][x + 2] == marker && grid[y][x + 3] == marker
    return true if grid[y][x - 1] == marker && grid[y][x + 1] == marker && grid[y][x + 2] == marker
    return true if grid[y][x - 2] == marker && grid[y][x - 1] == marker && grid[y][x + 1] == marker
    return true if grid[y][x - 3] == marker && grid[y][x - 2] == marker && grid[y][x - 1] == marker

    false
  end

  def check_vertical
    y, x = @last_visited
    grid = @grid
    marker = @move_status == false ? @first_player_symbol : @second_player_symbol
    directions = [[-1, 0]]
    directions.each do |dy, dx|
      sequences = (1..3).map do |i|
        grid[y + dy * i][x + dx * i] if (y + dy * i).between?(0, 5) && (x + dx * i).between?(0, 6)
      end
      return true if sequences.all?(marker)
    end
    false
  end

  def check_diagonal
    y, x = @last_visited
    grid = @grid
    marker = @move_status == false ? @first_player_symbol : @second_player_symbol
    directions = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    directions.each do |dy, dx|
      sequences = (1..3).map do |i|
        grid[y + dy * i][x + dx * i] if (y + dy * i).between?(0, 5) && (x + dx * i).between?(0, 6)
      end
      return true if sequences.all?(marker)
    end
    false
  end
end
