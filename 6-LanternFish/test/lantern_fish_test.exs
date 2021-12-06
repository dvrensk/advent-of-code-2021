defmodule LanternFishTest do
  use ExUnit.Case
  doctest LanternFish

  test "solves part 1" do
    assert LanternFish.p1(input_ints(), 80) == 390_923
  end

  test "solves part 2" do
    assert LanternFish.p2(input_ints(), 256) == 1_749_945_484_935
  end

  def input(path \\ "input.txt"), do: File.read!(path)
  def input_words(path \\ "input.txt"), do: input(path) |> String.split(~r/\s+/, trim: true)
  def input_lines(path \\ "input.txt"), do: input(path) |> String.split("\n", trim: true)
  def input_paragraphs(path \\ "input.txt"), do: input(path) |> String.split("\n\n", trim: true)

  def input_ints(path \\ "input.txt"),
    do:
      input(path)
      |> (&Regex.scan(~r/-?\d+/, &1)).()
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)

  def assert_eq(a, b), do: assert(a == b)
end
