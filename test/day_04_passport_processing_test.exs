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
    @valid Parser.parse_passport("""
           ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
           byr:1937 iyr:2017 cid:147 hgt:183cm
           """)

    test "byr valid:   2002" do
      assert %{@valid | byr: "2002"} |> Passport.strictly_valid?(:byr)
    end

    test "byr invalid: 2003" do
      refute %{@valid | byr: "2003"} |> Passport.strictly_valid?(:byr)
    end

    test "hgt valid:   60in" do
      assert %{@valid | hgt: "60in"} |> Passport.strictly_valid?(:hgt)
    end

    test "hgt valid:   190cm" do
      assert %{@valid | hgt: "190cm"} |> Passport.strictly_valid?(:hgt)
    end

    test "hgt invalid: 190in" do
      refute %{@valid | hgt: "190in"} |> Passport.strictly_valid?(:hgt)
    end

    test "hgt invalid: 190" do
      refute %{@valid | hgt: "190"} |> Passport.strictly_valid?(:hgt)
    end

    test "hcl valid:   #123abc" do
      assert %{@valid | hcl: "#123abc"} |> Passport.strictly_valid?(:hcl)
    end

    test "hcl invalid: #123abz" do
      refute %{@valid | hcl: "#123abz"} |> Passport.strictly_valid?(:hcl)
    end

    test "hcl invalid: 123abc" do
      refute %{@valid | hcl: "123abc"} |> Passport.strictly_valid?(:hcl)
    end

    test "ecl valid:   brn" do
      assert %{@valid | ecl: "brn"} |> Passport.strictly_valid?(:ecl)
    end

    test "ecl invalid: wat" do
      refute %{@valid | ecl: "wat"} |> Passport.strictly_valid?(:ecl)
    end

    test "pid valid:   000000001" do
      assert %{@valid | pid: "000000001"} |> Passport.strictly_valid?(:pid)
    end

    test "pid invalid: 0123456789" do
      refute %{@valid | pid: "0123456789"} |> Passport.strictly_valid?(:pid)
    end

    test_with_puzzle_input do
      assert 127 = puzzle_input() |> part_2()
    end
  end
end
