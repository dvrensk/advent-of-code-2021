defmodule VentsTest do
  use ExUnit.Case
  doctest Vents

  test "solves part 1" do
    assert Vents.count(input_lines(), 2) == 8060
  end

  test "solves part 2" do
    assert Vents.count(input_lines(), 2, true) == 21577
  end

  def input(path \\ "input.txt"), do: File.read!(path)
  def input_words(path \\ "input.txt"), do: input(path) |> String.split(~r/\s+/, trim: true)
  def input_lines(path \\ "input.txt"), do: input(path) |> String.split("\n", trim: true)
  def input_paragraphs(path \\ "input.txt"), do: input(path) |> String.split("\n\n", trim: true)

  def input_ints(path \\ "input.txt"),
    do: input(path) |> String.split() |> Enum.map(&String.to_integer/1)

  def assert_eq(a, b), do: assert(a == b)
end
