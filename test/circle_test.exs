defmodule Adventofcode.CircleTest do
  use Adventofcode.FancyCase

  import Adventofcode.Circle

  describe "new/0" do
    test "initializes a circular datastructure" do
      assert %{size: 0, counter: 0, current: 0} == new()
    end
  end

  describe "to_list/1" do
    test "collects all values into a list" do
      marbles =
        new()
        |> insert_next("hej")
        |> insert_next("hopp")
        |> insert_next("tada")

      assert ["tada", "hej", "hopp"] = to_list(marbles)
    end
  end

  describe "move_next/1" do
    test "moves current to what next was" do
      marbles =
        new()
        |> insert_next("hej")
        |> insert_next("hopp")
        |> insert_next("tada")

      assert %{current: 1} = marbles = move_next(marbles)
      assert %{current: 2} = marbles = move_next(marbles)
      assert %{current: 3} = move_next(marbles)
    end
  end

  describe "move_prev/1" do
    test "moves current to what next was" do
      marbles =
        new()
        |> insert_next("hej")
        |> insert_next("hopp")
        |> insert_next("tada")

      assert %{current: 2} = marbles = move_prev(marbles)
      assert %{current: 1} = marbles = move_prev(marbles)
      assert %{current: 3} = move_prev(marbles)
    end
  end

  describe "insert_next/0" do
    test "inserts initial value" do
      marbles = new()

      assert %{
               :size => 1,
               :counter => 1,
               :current => 1,
               1 => {1, "hej", 1}
             } == insert_next(marbles, "hej")
    end

    test "inserts a second value" do
      marbles = new() |> insert_next("hej")

      assert %{
               :size => 2,
               :counter => 2,
               :current => 2,
               1 => {2, "hej", 2},
               2 => {1, "hopp", 1}
             } == insert_next(marbles, "hopp")
    end

    test "inserts a third value, forming a circle" do
      marbles =
        new()
        |> insert_next("hej")
        |> insert_next("hopp")

      assert %{
               :size => 3,
               :counter => 3,
               :current => 3,
               1 => {3, "hej", 2},
               2 => {1, "hopp", 3},
               3 => {2, "tada", 1}
             } == insert_next(marbles, "tada")
    end
  end

  describe "remove_current/1" do
    test "removes first node" do
      marbles = new() |> insert_next("hej")

      assert %{
               :size => 0,
               :counter => 1,
               :current => 1
             } == remove_current(marbles)
    end

    test "removes second node" do
      marbles =
        new()
        |> insert_next("hej")
        |> insert_next("hopp")

      assert %{
               :size => 1,
               :counter => 2,
               :current => 1,
               1 => {1, "hej", 1}
             } == remove_current(marbles)
    end

    test "removes third node" do
      marbles =
        new()
        |> insert_next("hej")
        |> insert_next("hopp")
        |> insert_next("tada")

      assert %{
               :size => 2,
               :counter => 3,
               :current => 1,
               1 => {2, "hej", 2},
               2 => {1, "hopp", 1}
             } == remove_current(marbles)
    end

    test "removing a non existant node is a no-op" do
      marbles = new()

      assert %{
               :size => 0,
               :counter => 0,
               :current => 0
             } == remove_current(marbles)
    end
  end
end
