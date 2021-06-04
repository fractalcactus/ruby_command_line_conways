# frozen_string_literal: true

require_relative 'conways_command_line'
require 'test/unit'

# How run these tests:
# comment out all code outside of the ConwaysGame class at the bottom of conways_command_line.rb
# run `ruby conways_command_line_tests.rb`
class TestConwaysCommandLine < Test::Unit::TestCase
  DEAD_CELL_GRAPHIC = ' '
  ALIVE_CELL_GRAPHIC = 'X'
  BLINKER = [
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC]
  ].freeze

  TOAD = [
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC,
     DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC]
  ].freeze

  STAR = [
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC,
     ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC,
     ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     DEAD_CELL_GRAPHIC, ALIVE_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC],
    [DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC,
     DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC, DEAD_CELL_GRAPHIC]
  ].freeze

  def setup
    @conways_game_blinker = ConwaysGame.new(
      pattern_row_length: 5,
      pattern_col_length: 5,
      dead_cell_graphic: DEAD_CELL_GRAPHIC,
      alive_cell_graphic: ALIVE_CELL_GRAPHIC,
      pattern: :blinker
    )
    @conways_game_toad = ConwaysGame.new(
      pattern_row_length: 6,
      pattern_col_length: 6,
      dead_cell_graphic: DEAD_CELL_GRAPHIC,
      alive_cell_graphic: ALIVE_CELL_GRAPHIC,
      pattern: :toad
    )
    @conways_game_star = ConwaysGame.new(
      pattern_row_length: 15,
      pattern_col_length: 15,
      dead_cell_graphic: DEAD_CELL_GRAPHIC,
      alive_cell_graphic: ALIVE_CELL_GRAPHIC,
      pattern: :star
    )
    @conways_game_random = ConwaysGame.new(
      pattern_row_length: 14,
      pattern_col_length: 1,
      dead_cell_graphic: DEAD_CELL_GRAPHIC,
      alive_cell_graphic: ALIVE_CELL_GRAPHIC
    )
  end

  def test_initialization
    assert_equal(BLINKER, @conways_game_blinker.pattern)
    assert_equal(TOAD, @conways_game_toad.pattern)
    assert_equal(STAR, @conways_game_star.pattern)
    assert_equal(14, @conways_game_random.pattern_row_length)
  end

  # ----- Test private methods to ensure conway's algorithm runs correctly -----
  # This is necessary because the publicly exposed method ConwaysGame#run is comparatively hard to test,
  # as it would require a testing framework that could 'see' the output on the command line

  def test_count_neighbors
    # alive cells in BLINKER
    assert_equal(1, @conways_game_blinker.send(:count_neighbours, 1, 2))
    assert_equal(2, @conways_game_blinker.send(:count_neighbours, 2, 2))
    assert_equal(1, @conways_game_blinker.send(:count_neighbours, 3, 2))
    assert_equal(3, @conways_game_blinker.send(:count_neighbours, 2, 1))
    assert_equal(3, @conways_game_blinker.send(:count_neighbours, 2, 3))
    # alive cells in TOAD
    assert_equal(4, @conways_game_toad.send(:count_neighbours, 2, 2))
    assert_equal(4, @conways_game_toad.send(:count_neighbours, 2, 3))
    assert_equal(2, @conways_game_toad.send(:count_neighbours, 2, 4))
    assert_equal(2, @conways_game_toad.send(:count_neighbours, 3, 1))
    assert_equal(4, @conways_game_toad.send(:count_neighbours, 3, 2))
    assert_equal(4, @conways_game_toad.send(:count_neighbours, 3, 3))
    # dead cells in TOAD
    assert_equal(0, @conways_game_toad.send(:count_neighbours, 0, 0))
    assert_equal(0, @conways_game_toad.send(:count_neighbours, 0, 1))
    assert_equal(0, @conways_game_toad.send(:count_neighbours, 0, 2))
    assert_equal(0, @conways_game_toad.send(:count_neighbours, 0, 3))
    assert_equal(0, @conways_game_toad.send(:count_neighbours, 0, 4))
    assert_equal(0, @conways_game_toad.send(:count_neighbours, 0, 5))
    assert_equal(1, @conways_game_toad.send(:count_neighbours, 1, 1))
    assert_equal(2, @conways_game_toad.send(:count_neighbours, 1, 2))
    assert_equal(3, @conways_game_toad.send(:count_neighbours, 1, 3))
    assert_equal(2, @conways_game_toad.send(:count_neighbours, 1, 4))
  end

  def test_get_updated_cell_value
    # BLINKER
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_blinker.send(:get_updated_cell_value, 1, 2))
    assert_equal(ALIVE_CELL_GRAPHIC, @conways_game_blinker.send(:get_updated_cell_value, 2, 2))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_blinker.send(:get_updated_cell_value, 3, 2))
    assert_equal(ALIVE_CELL_GRAPHIC, @conways_game_blinker.send(:get_updated_cell_value, 2, 1))
    assert_equal(ALIVE_CELL_GRAPHIC, @conways_game_blinker.send(:get_updated_cell_value, 2, 3))
    # TOAD
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 0, 0))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 0, 1))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 0, 2))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 0, 3))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 0, 4))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 0, 5))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 1, 0))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 1, 1))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 1, 2))
    assert_equal(ALIVE_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 1, 3))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 1, 4))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 1, 5))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 2, 0))
    assert_equal(ALIVE_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 2, 1))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 2, 2))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 2, 3))
    assert_equal(ALIVE_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 2, 4))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 2, 5))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 3, 0))
    assert_equal(ALIVE_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 3, 1))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 3, 2))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 3, 3))
    assert_equal(ALIVE_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 3, 4))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 3, 5))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 4, 0))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 4, 1))
    assert_equal(ALIVE_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 4, 2))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 4, 3))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 4, 4))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 4, 5))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 5, 0))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 5, 1))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 5, 2))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 5, 3))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 5, 4))
    assert_equal(DEAD_CELL_GRAPHIC, @conways_game_toad.send(:get_updated_cell_value, 5, 5))
  end

  def test_click
    toad_ticked_once = [
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
    toad_ticked_twice = TOAD

    @conways_game_toad.send(:tick)
    assert_equal(toad_ticked_once, @conways_game_toad.pattern)

    @conways_game_toad.send(:tick)
    assert_equal(toad_ticked_twice, @conways_game_toad.pattern)
  end
end
