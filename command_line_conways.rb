# frozen_string_literal: true

# frozen_string_literal: true

# A program to play Conway's Game of Life in the command line
# https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
class CommandLineConways
  attr_accessor :pattern_row_length,
                :pattern_col_length,
                :dead_cell_graphic,
                :alive_cell_graphic,
                :pattern

  def initialize(
    pattern_row_length:,
    pattern_col_length:,
    dead_cell_graphic:,
    alive_cell_graphic:,
    pattern: :random
  )
    @pattern_row_length = pattern_row_length
    @pattern_row_length_zero_indexed = pattern_row_length - 1
    @pattern_col_length = pattern_col_length
    @pattern_col_length_zero_indexed = pattern_col_length - 1
    @dead_cell_graphic = dead_cell_graphic
    @alive_cell_graphic = alive_cell_graphic
    @pattern = case pattern
               when :toad
                 toad_seed
               when :blinker
                 blinker_seed
               when :star
                 star_seed
               else
                 randomize_seed
               end
    @next_pattern = Array.new(@pattern_row_length) { Array.new(@pattern_col_length) { nil } }
  end

  def run
    loop do
      system('clear') || system('cls')
      print_pattern
      sleep(0.05)
      tick
      system('clear') || system('cls')
      print_pattern
      sleep(0.05)
    end
  end

  private

  def print_pattern
    @pattern.each do |row|
      row.each do |col|
        print col
      end
      print "\n"
    end
  end

  def tick
    @pattern.each_with_index do |row, row_index|
      row.each_with_index do |_col, col_index|
        @next_pattern[row_index][col_index] = get_updated_cell_value(row_index, col_index)
      end
    end
    @pattern = Marshal.load(Marshal.dump(@next_pattern)) # deep copy array
  end

  # Conway's rules:
  # - any live cell with two or three live neighbours survives.
  # - any dead cell with three live neighbours becomes a live cell
  # - all other live cells die in the next generation
  # - all other dead cells stay dead
  def get_updated_cell_value(row_index, col_index)
    is_alive = @pattern[row_index][col_index] == @alive_cell_graphic
    total_neighbors = count_neighbours(row_index, col_index)
    return @alive_cell_graphic if is_alive && [2, 3].include?(total_neighbors)

    return @alive_cell_graphic if !is_alive & (total_neighbors == 3)

    @dead_cell_graphic
  end

  def count_neighbours(row_index, col_index)
    neighbors = 0
    coordinates_of_surrounding_cells = get_coordinates_of_surrounding_cells(row_index, col_index)
    # for each coordinate in coordinates_of_surrounding_cells,
    # increment neighbors if pattern contains a @alive_cell_graphic at that coordinate
    # the coordinates are in the form [row,col]
    coordinates_of_surrounding_cells.each do |coord|
      surrounding_cell_row = coord[0]
      surrounding_cell_col = coord[1]
      neighbors += 1 if @pattern[surrounding_cell_row][surrounding_cell_col] == @alive_cell_graphic
    end
    neighbors
  end

  def get_coordinates_of_surrounding_cells(row_index, col_index)
    surrounding_cells = []
    # get the coordinates of cells that are horizontally, vertically, or diagonally adjacent
    # to the parameters row, col
    # this will include invalid negative indices

    # one row up, one col left
    surrounding_cells << [row_index - 1, col_index - 1] unless (row_index == 0) || (col_index == 0)
    # one row up, same col
    surrounding_cells << [row_index - 1, col_index] unless row_index == 0
    # one row up, one col right
    surrounding_cells << [row_index - 1, col_index + 1] unless (row_index == 0) || (col_index == @pattern_col_length_zero_indexed)
    # same row, one col left
    surrounding_cells << [row_index, col_index - 1] unless col_index == 0
    # same row, one col right
    surrounding_cells << [row_index, col_index + 1] unless col_index == @pattern_col_length_zero_indexed
    # one row down, one col left
    surrounding_cells << [row_index + 1, col_index - 1] unless (row_index == @pattern_row_length_zero_indexed) || (col_index == 0)
    # one row down, same col
    surrounding_cells << [row_index + 1, col_index] unless row_index == @pattern_row_length_zero_indexed
    # one row down, one col right
    surrounding_cells << [row_index + 1, col_index + 1] unless (row_index == @pattern_row_length_zero_indexed) || (col_index == @pattern_col_length_zero_indexed)

    # # remove invalid negative indices
    # surrounding_cells.reject! do |cell|
    #   cell.any?(&:negative?)
    # end

    # # remove coordinates outside the bounds of the pattern
    # surrounding_cells.reject! do |cell|
    #   cell[0] >= @pattern_row_length_zero_indexed  || cell[1] >= @pattern_col_length_zero_indexed
    # end

    surrounding_cells
  end

  def randomize_seed
    Array.new(@pattern_row_length) { Array.new(@pattern_col_length) { [@dead_cell_graphic, @alive_cell_graphic].sample } }
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

# examples of running the game:

# @conways_game_blinker = CommandLineConways.new(
#       pattern_row_length: 5,
#       pattern_col_length: 5,
#       dead_cell_graphic: ' ',
#       alive_cell_graphic: 'X',
#       pattern: :blinker
#     )
# @conways_game_blinker.run

# @conways_game_toad = CommandLineConways.new(
#   pattern_row_length: 6,
#   pattern_col_length: 6,
#   dead_cell_graphic: ' ',
#   alive_cell_graphic: '𓆏 ',
#   pattern: :toad
# )
# @conways_game_toad.run

# @conways_game_star = CommandLineConways.new(
#   pattern_row_length: 16,
#   pattern_col_length: 15,
#   dead_cell_graphic: ' ',
#   alive_cell_graphic: '𓇬',
#   pattern: :star
# )
# @conways_game_star.run

# @conways_game_random = CommandLineConways.new(
#   pattern_row_length: 150,
#   pattern_col_length: 150,
#   dead_cell_graphic: ' ',
#   alive_cell_graphic: '𓆦',
# )
# @conways_game_random.run
