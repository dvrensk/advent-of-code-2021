defmodule DiveTest do
  use ExUnit.Case
  doctest Dive

  test "solves 1" do
    assert Dive.dive(input_words()) == {1939, 1109}
  end

  test "solves 2" do
    assert Dive.dive2(input_words()) == {1939, 950357, 1109}
  end

  def input(path \\ "input.txt"), do: File.read!(path)
  def input_words(path \\ "input.txt"), do: input(path) |> String.split(~r/\s+/, trim: true)
  def input_lines(path \\ "input.txt"), do: input(path) |> String.split("\n", trim: true)
  def input_paragraphs(path \\ "input.txt"), do: input(path) |> String.split("\n\n", trim: true)

  def input_ints(path \\ "input.txt"),
    do: input(path) |> String.split() |> Enum.map(&String.to_integer/1)

  def assert_eq(a, b), do: assert(a == b)
end
