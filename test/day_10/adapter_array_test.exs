defmodule Advent.Day10.AdapterArrayTest do
  use ExUnit.Case
  alias Advent.Day10.AdapterArray

  test "it can find how many of each jolt jumps there is" do
    assert AdapterArray.find_jumps("
      28
      33
      18
      42
      31
      14
      46
      20
      48
      47
      24
      23
      49
      45
      19
      38
      39
      11
      1
      32
      25
      35
      8
      17
      7
      9
      4
      2
      34
      10
      3
    ") == %{one: 22, three: 10}
  end

  test "it can find sequenses" do
    assert AdapterArray.find_ranges(
      AdapterArray.parse_input("
        28
        33
        18
        42
        31
        14
        46
        20
        48
        47
        24
        23
        49
        45
        19
        38
        39
        11
        1
        32
        25
        35
        8
        17
        7
        9
        4
        2
        34
        10
        3
      ") |> Enum.sort()
    ) == [[1, 2, 3, 4], [8, 9, 10, 11], [18, 19, 20], [24, 25], [32, 33, 34, 35], [39]]
  end

  test "it can find all combinations" do
    assert AdapterArray.possible_combinations_in_range(
      [],
      [1,2,3,4]
    ) == [[1, 2, 3, 4], [1, 2, 4], [1, 3, 4], [1, 4], [2, 3, 4], [2, 4], [3, 4], [4]]
  end

  test "it can find all possible jolt combinations" do
    assert AdapterArray.all_possible_combinations_count("
      28
      33
      18
      42
      31
      14
      46
      20
      48
      47
      24
      23
      49
      45
      19
      38
      39
      11
      1
      32
      25
      35
      8
      17
      7
      9
      4
      2
      34
      10
      3
    ") == 2
  end
end
