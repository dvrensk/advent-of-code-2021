defmodule SonarSweepTest do
  use ExUnit.Case
  doctest SonarSweep

  test "solves the first part" do
    assert SonarSweep.count_increases((input_ints())) == 1475
  end

  test "solves the second part" do
    assert SonarSweep.count_in_windows((input_ints())) == 1516
  end

  def input(path \\ "input.txt"), do: File.read!(path)
  def input_lines(path \\ "input.txt"), do: input(path) |> String.split("\n", trim: true)
  def input_paragraphs(path \\ "input.txt"), do: input(path) |> String.split("\n\n", trim: true)

  def input_ints(path \\ "input.txt"),
    do: input(path) |> String.split() |> Enum.map(&String.to_integer/1)

  def assert_eq(a, b), do: assert(a == b)
end
