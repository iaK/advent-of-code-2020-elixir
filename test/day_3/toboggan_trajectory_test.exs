defmodule Day3.TobogganTrajectoryTest do
  use ExUnit.Case
  alias Advent.Day3.PathFinder

  test "it can find how many trees it would hit" do
    assert PathFinder.trees_hit("
      ..##.......
      #...#...#..
      .#....#..#.
      ..#.#...#.#
      .#...##..#.
      ..#.##.....
      .#.#.#....#
      .#........#
      #.##...#...
      #...##....#
      .#..#...#.#
    ") == 7
  end
end
