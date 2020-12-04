defmodule Adventofcode.Day04PassportProcessingTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day04PassportProcessing

  alias Adventofcode.Day04PassportProcessing.{Passport, Parser}

  describe "part_1/1" do
    @batch_file """
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
    """
    test "example batch file containing four passports" do
      assert [%Passport{}, %Passport{}, %Passport{}, %Passport{}] = @batch_file |> Parser.parse()
    end

    @passport """
    ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
    byr:1937 iyr:2017 cid:147 hgt:183cm
    """
    test "valid - all eight fields are present" do
      assert %Passport{
               byr: "1937",
               cid: "147",
               ecl: "gry",
               eyr: "2020",
               hcl: "#fffffd",
               hgt: "183cm",
               iyr: "2017",
               pid: "860033327",
               valid?: true
             } = @passport |> Parser.parse_passport()
    end

    @passport """
    iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
    hcl:#cfa07d byr:1929
    """
    test "invalid - it is missing hgt (the Height field)" do
      assert %Passport{
               byr: "1929",
               cid: "350",
               ecl: "amb",
               eyr: "2023",
               hcl: "#cfa07d",
               hgt: nil,
               iyr: "2013",
               pid: "028048884",
               valid?: false
             } = @passport |> Parser.parse_passport()
    end

    @passport """
    hcl:#ae17e1 iyr:2013
    eyr:2024
    ecl:brn pid:760753108 byr:1931
    hgt:179cm
    """
    test "interesting; the only missing field is cid, treat as valid" do
      assert %Passport{
               byr: "1931",
               cid: nil,
               ecl: "brn",
               eyr: "2024",
               hcl: "#ae17e1",
               hgt: "179cm",
               iyr: "2013",
               pid: "760753108",
               valid?: true
             } = @passport |> Parser.parse_passport()
    end

    @passport """
    hcl:#cfa07d eyr:2025 pid:166559648
    iyr:2011 ecl:brn hgt:59in
    """
    test "Missing cid is fine, but missing any other field is not, so this passport is invalid" do
      assert %Passport{
               byr: nil,
               cid: nil,
               ecl: "brn",
               eyr: "2025",
               hcl: "#cfa07d",
               hgt: "59in",
               iyr: "2011",
               pid: "166559648",
               valid?: false
             } = @passport |> Parser.parse_passport()
    end

    test "your improved system would report 2 valid passports" do
      assert 2 = @batch_file |> part_1()
    end

    test_with_puzzle_input do
      assert 219 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    # test "" do
    #   assert 1337 = 1337 |> part_2()
    # end

    # test_with_puzzle_input do
    #   assert 1337 = puzzle_input() |> part_2()
    # end
  end
end
