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
  # return either @alive_cell_graphic or @dead_cell_graphic
  def get_updated_cell_value(row_index, col_index)
    is_alive = @pattern[row_index][col_index] == @alive_cell_graphic
    total_neighbors = count_neighbours(row_index, col_index)
    return @alive_cell_graphic if is_alive && [2, 3].include?(total_neighbors)

    return @alive_cell_graphic if !is_alive & (total_neighbors == 3)

    @dead_cell_graphic
  end

  # for each coordinate in coordinates_of_surrounding_cells,
  # increment neighbors if pattern contains a @alive_cell_graphic at that coordinate
  # the coordinates are in the form [row,col]
  # return an integer >= 0
  def count_neighbours(row_index, col_index)
    neighbors = 0
    coordinates_of_surrounding_cells = get_coordinates_of_surrounding_cells(row_index, col_index)
    coordinates_of_surrounding_cells.each do |coord|
      surrounding_cell_row = coord[0]
      surrounding_cell_col = coord[1]
      neighbors += 1 if @pattern[surrounding_cell_row][surrounding_cell_col] == @alive_cell_graphic
    end
    neighbors
  end

  # get the coordinates of cells that are horizontally, vertically, or diagonally adjacent
  # to the parameters (row_index, col_index)
  # don't check out of bound indices
  # return a 2D array of coordinates in the form [[row, col], [row, col] ... [row, col]]
  def get_coordinates_of_surrounding_cells(row_index, col_index)
    surrounding_cells = []

    # one row up, one col left
    unless top_edge_of_pattern?(row_index) || left_edge_of_pattern?(col_index)
      surrounding_cells << [row_index - 1, col_index - 1]
    end
    # one row up, same col
    surrounding_cells << [row_index - 1, col_index] unless top_edge_of_pattern?(row_index)
    # one row up, one col right
    unless top_edge_of_pattern?(row_index) || right_edge_of_pattern?(col_index)
      surrounding_cells << [row_index - 1, col_index + 1]
    end
    # same row, one col left
    surrounding_cells << [row_index, col_index - 1] unless left_edge_of_pattern?(col_index)
    # same row, one col right
    surrounding_cells << [row_index, col_index + 1] unless right_edge_of_pattern?(col_index)
    # one row down, one col left
    unless bottem_edge_of_pattern?(row_index) || left_edge_of_pattern?(col_index)
      surrounding_cells << [row_index + 1, col_index - 1]
    end
    # one row down, same col
    surrounding_cells << [row_index + 1, col_index] unless bottem_edge_of_pattern?(row_index)
    # one row down, one col right
    unless bottem_edge_of_pattern?(row_index) || right_edge_of_pattern?(col_index)
      surrounding_cells << [row_index + 1, col_index + 1]
    end

    surrounding_cells
  end

  def left_edge_of_pattern?(col_index)
    col_index.zero?
  end

  def top_edge_of_pattern?(row_index)
    row_index.zero?
  end

  def right_edge_of_pattern?(col_index)
    col_index == @pattern_col_length_zero_indexed
  end

  def bottem_edge_of_pattern?(row_index)
    row_index == @pattern_row_length_zero_indexed
  end

  def randomize_seed
    Array.new(@pattern_row_length) do
      Array.new(@pattern_col_length) do
        [@dead_cell_graphic, @alive_cell_graphic].sample
      end
    end
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
#   alive_cell_graphic: '???? ',
#   pattern: :toad
# )
# @conways_game_toad.run

# @conways_game_star = CommandLineConways.new(
#   pattern_row_length: 16,
#   pattern_col_length: 15,
#   dead_cell_graphic: ' ',
#   alive_cell_graphic: '????',
#   pattern: :star
# )
# @conways_game_star.run

@conways_game_random = CommandLineConways.new(
  pattern_row_length: 150,
  pattern_col_length: 150,
  dead_cell_graphic: ' ',
  alive_cell_graphic: '????'
)
@conways_game_random.run
