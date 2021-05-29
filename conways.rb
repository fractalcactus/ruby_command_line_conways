# -------------------Seeds-------------------
# a 'seed' is the starting pattern for the game
BLINKER = [
           [0,0,0,0,0],
           [0,0,1,0,0],
           [0,0,1,0,0],
           [0,0,1,0,0],
           [0,0,0,0,0]
          ]
TOAD = [
[0,0,0,0,0,0],
[0,0,0,0,0,0],
[0,0,1,1,1,0],
[0,1,1,1,0,0],
[0,0,0,0,0,0],
[0,0,0,0,0,0]
]

#### 1 parameter
# - pattern, a 2D array, representing rows and columns
### output
# - a 2D array, representing rows and cols, the next click of conways
def click(pattern)
  next_pattern = Array.new(pattern.length) { Array.new(pattern.length){nil} }
  pattern.each_with_index do |row, row_index|
    row.each_with_index do |_col, col_index|
      next_pattern[row_index][col_index] = update_cell_value(row_index,col_index,pattern)
    end
  end
  next_pattern
end

#### 1 parameter
# - pattern, a 2D array, representing rows and columns
### output
# - prints out a 2D array to the command line
def print_pattern(pattern)
  pattern.each do |row|
    row.each do |col|
      print col
    end
    print "\n"
  end
end

#### 3 paramters
# 1. row, integer representing the row coordinate of a cell in the pattern
# 2. col, integer representing the column coordinate of a cell in the pattern
# 3. patttern, a 2D array
#### output
# returns an integer representing the total of a cell's neighbors
# a cell can have up to eight neighbors.
# a neighbor is a cell that is 'alive', i.e contains a 1, and
# is horizontally, vertically, or diagonally adjacent
def count_neighbours(row, col, pattern)
 neighbors = 0
 coordinates_of_surrounding_cells = get_coordinates_of_surrounding_cells(row, col, pattern)
 # for each coordinate in coordinates_of_surrounding_cells,
 # increment neighbors if pattern contains a 1 at that coordinate
 # the coordinates are in the form [row,col]
 coordinates_of_surrounding_cells.each do |coord|
  surrounding_cell_row = coord[0]
  surrounding_cell_col = coord[1]
  if pattern[surrounding_cell_row][surrounding_cell_col] == 1
    neighbors +=1
  end
 end
 neighbors
end

#### 3 paramters
# 1. row, integer representing the row coordinate of a cell in the pattern
# 2. col, integer representing the column coordinate of a cell in the pattern
# 3. patttern, a 2D array
###  output
# returns an array of coordinate arrays in the form [row,col]
# TODO: these are not neighbours. a neighbor is alive. these are surrounding
def get_coordinates_of_surrounding_cells (row, col, pattern)
  neighbors = []
  # get the coordinates of cells that are horizontally, vertically, or diagonally adjacent
  # to the parameters row, col
  # this will include invalid negative indices
  # TODO: optimise this to not bother checking out of bound indices
  neighbors << [row - 1, col - 1]
  neighbors << [row - 1, col]
  neighbors << [row - 1, col + 1]
  neighbors << [row, col - 1]
  neighbors << [row, col + 1]
  neighbors << [row + 1, col - 1]
  neighbors << [row + 1, col]
  neighbors << [row + 1, col + 1];
  # remove invalid negative indices,

  neighbors.reject!{|neighbor|
    neighbor.any?{|coord| coord < 0}
  }

  # remove coordinates outside the bounds of the pattern, if row is greater than the zero indexed rows || col is greater than the zero indexed
  neighbors.reject!{|neighbor|
   neighbor[0] >= pattern.length || neighbor[1] >= pattern.length
  }

  neighbors
end
#### 3 paramters
# 1. row, integer representing the row coordinate of a cell in the pattern
# 2. col, integer representing the column coordinate of a cell in the pattern
# 3. patttern, a 2D array
###  output
# returns a 1 or 0, 1 represents an alive cell, 0 represents a dead cell
def update_cell_value(row, col, pattern)
  # Any live cell with two or three live neighbours survives.
  # Any dead cell with three live neighbours becomes a live cell.
  # All other live cells die in the next generation. Similarly, all other dead cells stay dead.
  is_alive = pattern[row][col] == 1
  total_neighbors = count_neighbours(row, col, pattern)
  if is_alive && (total_neighbors == 2 || total_neighbors == 3)
    return 1
  end

  if !is_alive & (total_neighbors == 3)
    return 1
  end

  return 0
end




def run_conways(initial_pattern)
  while true do
    system("clear") || system("cls")
    print_pattern(initial_pattern)
    sleep(1)
    clicked_pattern = click(initial_pattern)
    system("clear") || system("cls")
    print_pattern(clicked_pattern)
    sleep(1)
    initial_pattern = clicked_pattern
  end
end

system("clear") || system("cls")
puts "conways is starting"
sleep(1)

run_conways(BLINKER)
