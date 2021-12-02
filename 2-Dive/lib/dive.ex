defmodule Dive do
  @doc """
  iex> Dive.sample()
  ...> |> String.split(~r/\\s+/, trim: true)
  ...> |> Dive.dive()
  {15, 10}
  """
  def dive(commands), do: dive(commands, {0, 0})

  def dive([], pos), do: pos
  def dive(["down", n | rest], {x, y}), do: dive(rest, {x, y + int(n)})
  def dive(["up", n | rest], {x, y}), do: dive(rest, {x, y - int(n)})
  def dive(["forward", n | rest], {x, y}), do: dive(rest, {x + int(n), y})

  @doc """
  iex> Dive.sample()
  ...> |> String.split(~r/\\s+/, trim: true)
  ...> |> Dive.dive2()
  {15, 60, 10}
  """
  def dive2(commands), do: dive2(commands, {0, 0, 0})

  def dive2([], pos), do: pos
  def dive2(["down", n | rest], {x, y, aim}), do: dive2(rest, {x, y, aim + int(n)})
  def dive2(["up", n | rest], {x, y, aim}), do: dive2(rest, {x, y, aim - int(n)})

  def dive2(["forward", n | rest], {x, y, aim}),
    do: dive2(rest, {x + int(n), y + int(n) * aim, aim})

  defp int(n), do: String.to_integer(n)

  def sample() do
    """
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
    """
  end
end
