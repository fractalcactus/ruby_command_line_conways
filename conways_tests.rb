# frozen_string_literal: true

require_relative 'conways'
require 'test/unit'

class TestConways < Test::Unit::TestCase
  def test_get_coordinates_of_neighbors
    surrounding_cells_for_row_1_col_2 = [
      [0, 1], [0, 2], [0, 3],
      [1, 1], [1, 3],
      [2, 1], [2, 2], [2, 3]
    ]
    assert_equal(surrounding_cells_for_row_1_col_2, get_coordinates_of_surrounding_cells(1, 2, BLINKER))

    surrounding_cells_for_row_0_col_0 = [
      [0, 1],
      [1, 0],
      [1, 1]
    ]
    assert_equal(surrounding_cells_for_row_0_col_0, get_coordinates_of_surrounding_cells(0, 0, BLINKER))
  end

  def test_count_neighbors
    # alive cells in BLINKER
    assert_equal(1, count_neighbours(1, 2, BLINKER))
    assert_equal(2, count_neighbours(2, 2, BLINKER))
    assert_equal(1, count_neighbours(3, 2, BLINKER))
    # dead cells in BlINKER
    assert_equal(3, count_neighbours(2, 1, BLINKER))
    assert_equal(3, count_neighbours(2, 3, BLINKER))
    # alive cells in TOAD
    assert_equal(4, count_neighbours(2, 2, TOAD))
    assert_equal(4, count_neighbours(2, 3, TOAD))
    assert_equal(2, count_neighbours(2, 4, TOAD))
    assert_equal(2, count_neighbours(3, 1, TOAD))
    assert_equal(4, count_neighbours(3, 2, TOAD))
    assert_equal(4, count_neighbours(3, 3, TOAD))
    # dead cells in TOAD
    assert_equal(0, count_neighbours(0, 0, TOAD))
    assert_equal(0, count_neighbours(0, 1, TOAD))
    assert_equal(0, count_neighbours(0, 2, TOAD))
    assert_equal(0, count_neighbours(0, 3, TOAD))
    assert_equal(0, count_neighbours(0, 4, TOAD))
    assert_equal(0, count_neighbours(0, 5, TOAD))
    assert_equal(1, count_neighbours(1, 1, TOAD))
    assert_equal(2, count_neighbours(1, 2, TOAD))
    assert_equal(3, count_neighbours(1, 3, TOAD))
    assert_equal(2, count_neighbours(1, 4, TOAD))
  end

  def test_update_cell_value
    # BLINKER
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(1, 2, BLINKER))
    assert_equal(ALIVE_CELL_GRAPHIC, update_cell_value(2, 2, BLINKER))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(3, 2, BLINKER))
    assert_equal(ALIVE_CELL_GRAPHIC, update_cell_value(2, 1, BLINKER))
    assert_equal(ALIVE_CELL_GRAPHIC, update_cell_value(2, 3, BLINKER))
    # TOAD
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(0, 0, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(0, 1, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(0, 2, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(0, 3, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(0, 4, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(0, 5, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(1, 0, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(1, 1, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(1, 2, TOAD))
    assert_equal(ALIVE_CELL_GRAPHIC, update_cell_value(1, 3, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(1, 4, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(1, 5, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(2, 0, TOAD))
    assert_equal(ALIVE_CELL_GRAPHIC, update_cell_value(2, 1, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(2, 2, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(2, 3, TOAD))
    assert_equal(ALIVE_CELL_GRAPHIC, update_cell_value(2, 4, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(2, 5, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(3, 0, TOAD))
    assert_equal(ALIVE_CELL_GRAPHIC, update_cell_value(3, 1, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(3, 2, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(3, 3, TOAD))
    assert_equal(ALIVE_CELL_GRAPHIC, update_cell_value(3, 4, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(3, 5, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(4, 0, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(4, 1, TOAD))
    assert_equal(ALIVE_CELL_GRAPHIC, update_cell_value(4, 2, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(4, 3, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(4, 4, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(4, 5, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(5, 0, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(5, 1, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(5, 2, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(5, 3, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(5, 4, TOAD))
    assert_equal(DEAD_CELL_GRAPHIC, update_cell_value(5, 5, TOAD))
  end

  def test_click
    toad_clicked_once = [
      [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
       DEAD_CELL_GRAPHIC],
      [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
       DEAD_CELL_GRAPHIC],
      [DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC,
       DEAD_CELL_GRAPHIC],
      [DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC,
       DEAD_CELL_GRAPHIC],
      [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
       DEAD_CELL_GRAPHIC],
      [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC]
    ]
    toad_clicked_twice = TOAD
    assert_equal(toad_clicked_once, click(TOAD))
    assert_equal(toad_clicked_twice, click(toad_clicked_once))
  end
end
