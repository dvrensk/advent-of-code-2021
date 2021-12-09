defmodule SmokeBasinTest do
  use ExUnit.Case
  doctest SmokeBasin

  test "Solves part 1" do
    assert SmokeBasin.p1(input()) == 518
  end

  test "Solves part 2" do
    assert SmokeBasin.p2(input()) == 949_905
  end

  def input(path \\ "input.txt"), do: File.read!(path)
  def input_words(path \\ "input.txt"), do: input(path) |> String.split(~r/\s+/, trim: true)
  def input_lines(path \\ "input.txt"), do: input(path) |> String.split("\n", trim: true)
  def input_paragraphs(path \\ "input.txt"), do: input(path) |> String.split("\n\n", trim: true)

  def input_ints(path \\ "input.txt"),
    do: input(path) |> String.split() |> Enum.map(&String.to_integer/1)

  def assert_eq(a, b), do: assert(a == b)
end
