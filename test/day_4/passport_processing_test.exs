defmodule Day4.PassportProcessingTest do
  use ExUnit.Case
  alias Advent.Day4.PassportValidator
  alias Advent.Day4.Passport

  test "it can separate the input into different passports" do
    passports = PassportValidator.parse_input("
      ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
      byr:1937 iyr:2017 cid:147 hgt:183cm

      iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
      hcl:#cfa07d byr:1929

      hcl:#ae17e1 iyr:2013
      eyr:2024
      ecl:brn pid:760753108 byr:1931
      hgt:179cm

      hcl:#cfa07d eyr:2025 pid:166559648
      iyr:2011 ecl:brn hgt:59in
    ")

    assert Enum.count(passports) == 4
    assert [%Passport{},%Passport{},%Passport{},%Passport{}] = passports
  end

  test "it can validate a passport" do
    passport = Passport.new("ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
    byr:1937 iyr:2017 cid:147 hgt:183cm")
    assert Passport.is_valid?(passport) == true

    passport = Passport.new("iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
    hcl:#cfa07d byr:1929")
    assert Passport.is_valid?(passport) == false

    passport = Passport.new("hcl:#ae17e1 iyr:2013
    eyr:2024
    ecl:brn pid:760753108 byr:1931
    hgt:179cm")
    assert Passport.is_valid?(passport) == true

    passport = Passport.new("hcl:#cfa07d eyr:2025 pid:166559648
    iyr:2011 ecl:brn hgt:59in")
    assert Passport.is_valid?(passport) == false
  end

  test "it knows how many passports are valid" do
    assert PassportValidator.valid_passport_count("
      ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
      byr:1937 iyr:2017 cid:147 hgt:183cm

      iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
      hcl:#cfa07d byr:1929

      hcl:#ae17e1 iyr:2013
      eyr:2024
      ecl:brn pid:760753108 byr:1931
      hgt:179cm

      hcl:#cfa07d eyr:2025 pid:166559648
      iyr:2011 ecl:brn hgt:59in
    ") == 2
  end

  test "it can validate height" do
    assert Passport.has_height?("150cm") == true
    assert Passport.has_height?("149cm") == false
    assert Passport.has_height?("194cm") == false

    assert Passport.has_height?("60in") == true
    assert Passport.has_height?("58in") == false
    assert Passport.has_height?("77in") == false
  end

  test "it can validate hair color" do
    assert Passport.has_hair_color?("#123hjk") == true
    assert Passport.has_hair_color?("123hjk") == false
    assert Passport.has_hair_color?("#12_hjk") == false
    assert Passport.has_hair_color?("#123hjk2") == false
  end

  test "it can validate eye color" do
    assert Passport.has_eye_color?("amb") == true
    assert Passport.has_eye_color?("blu") == true
    assert Passport.has_eye_color?("brn") == true
    assert Passport.has_eye_color?("gry") == true
    assert Passport.has_eye_color?("grn") == true
    assert Passport.has_eye_color?("hzl") == true
    assert Passport.has_eye_color?("oth") == true
    assert Passport.has_eye_color?("nej") == false
    assert Passport.has_eye_color?("då") == false
  end

  test "it can validate passport number" do
    assert Passport.has_passport_id?("002938456") == true
    assert Passport.has_passport_id?("182937465") == true
    assert Passport.has_passport_id?("8918283828") == false
    assert Passport.has_passport_id?("a882838383") == false
    assert Passport.has_passport_id?("8283a828") == false
  end
end
