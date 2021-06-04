# frozen_string_literal: true

require 'pry-nav'

class ConwaysGame
  attr_accessor :initial_pattern_row_length,
                :initial_pattern_col_length,
                :dead_cell_graphic,
                :alive_cell_graphic,
                :initial_pattern

  def initialize(
    initial_pattern_row_length:,
    initial_pattern_col_length:,
    dead_cell_graphic:,
    alive_cell_graphic:,
    initial_pattern: randomize_seed
  )
    @initial_pattern_row_length = initial_pattern_row_length
    @initial_pattern_col_length = initial_pattern_col_length
    @dead_cell_graphic = dead_cell_graphic
    @alive_cell_graphic = alive_cell_graphic
    @initial_pattern = case initial_pattern
                       when :toad
                         toad_seed
                       when :blinker
                         blinker_seed
                       when :star
                         star_seed
                       else
                         initial_pattern
                       end
    @next_pattern = Array.new(@initial_pattern_row_length) { Array.new(initial_pattern_col_length) { nil } }
  end

  def run
    loop do
      system('clear') || system('cls')
      print_pattern
      sleep(0.05)
      click_pattern
      system('clear') || system('cls')
      print_pattern
      sleep(0.05)
    end
  end

  private

  def print_pattern
    @initial_pattern.each do |row|
      row.each do |col|
        print col
      end
      print "\n"
    end
  end

  def click_pattern
    @initial_pattern.each_with_index do |row, row_index|
      row.each_with_index do |_col, col_index|
        @next_pattern[row_index][col_index] = update_cell_value(row_index, col_index)
      end
    end
    @initial_pattern = Marshal.load(Marshal.dump(@next_pattern))
  end

  def update_cell_value(row_index, col_index) # TODO: it doesn't update, it returns a value. Alter the names for other methods too
    # Any live cell with two or three live neighbours survives.
    # Any dead cell with three live neighbours becomes a live cell.
    # All other live cells die in the next generation. Similarly, all other dead cells stay dead.
    is_alive = @initial_pattern[row_index][col_index] == @alive_cell_graphic
    total_neighbors = count_neighbours(row_index, col_index)
    return @alive_cell_graphic if is_alive && [2, 3].include?(total_neighbors)

    return @alive_cell_graphic if !is_alive & (total_neighbors == 3)

    @dead_cell_graphic
  end

  def count_neighbours(row_index, col_index)
    neighbors = 0
    coordinates_of_surrounding_cells = get_coordinates_of_surrounding_cells(row_index, col_index)
    # for each coordinate in coordinates_of_surrounding_cells,
    # increment neighbors if pattern contains a 1 at that coordinate
    # the coordinates are in the form [row,col]
    coordinates_of_surrounding_cells.each do |coord|
      surrounding_cell_row = coord[0]
      surrounding_cell_col = coord[1]
      neighbors += 1 if @initial_pattern[surrounding_cell_row][surrounding_cell_col] == @alive_cell_graphic
    end
    neighbors
  end

  def get_coordinates_of_surrounding_cells(row_index, col_index)
    neighbors = []
    # get the coordinates of cells that are horizontally, vertically, or diagonally adjacent
    # to the parameters row, col
    # this will include invalid negative indices
    # TODO: optimise this to not bother checking out of bound indices
    neighbors << [row_index - 1, col_index - 1]
    neighbors << [row_index - 1, col_index]
    neighbors << [row_index - 1, col_index + 1]
    neighbors << [row_index, col_index - 1]
    neighbors << [row_index, col_index + 1]
    neighbors << [row_index + 1, col_index - 1]
    neighbors << [row_index + 1, col_index]
    neighbors << [row_index + 1, col_index + 1]
    # remove invalid negative indices,

    neighbors.reject! do |neighbor|
      neighbor.any?(&:negative?)
    end

    # remove coordinates outside the bounds of the pattern, if row is greater than the zero indexed rows || col is greater than the zero indexed
    neighbors.reject! do |neighbor|
      neighbor[0] >= @initial_pattern_row_length || neighbor[1] >= @initial_pattern_col_length
    end

    neighbors
  end

  def randomize_seed
    Array.new(100) { Array.new(100) { [@dead_cell_graphic, @alive_cell_graphic].sample } }
  end

  def blinker_seed
    [
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic]
    ]
  end

  def toad_seed
    [
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @alive_cell_graphic,
       @dead_cell_graphic],
      [@dead_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic]
    ]
  end

  def star_seed
    [
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic,
       @alive_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic,
       @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @alive_cell_graphic,
       @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @alive_cell_graphic,
       @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic,
       @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic,
       @alive_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic, @dead_cell_graphic, @alive_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic],
      [@dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic,
       @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic, @dead_cell_graphic]
    ]
  end
end
