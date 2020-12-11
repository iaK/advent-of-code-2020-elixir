defmodule Day2.PaswordPhilosophyTest do
  use ExUnit.Case
  alias Advent.Day2.PasswordValidator

  test "it can get how many valid sled rental passwords there is" do
    assert PasswordValidator.valid_sled_rental_password_count("
      1-3 a: abcde
      1-3 b: cdefg
      2-9 c: ccccccccc
    ") == 2
  end

  test "it can get how many valid toboggan passwords there is" do
    assert PasswordValidator.valid_toboggan_password_count("
      1-3 a: abcde
      1-3 b: cdefg
      2-9 c: ccccccccc
    ") == 1
  end
end
