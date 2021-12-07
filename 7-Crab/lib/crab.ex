defmodule Crab do
  @doc """
  iex> Crab.p1(Crab.sample())
  {2, 37}
  """
  def p1(list) do
    crabs =
      list
      |> Enum.frequencies()

    {min, max} = Enum.min_max(list)

    min..max
    |> Enum.map(fn pos -> {pos, cost(crabs, pos)} end)
    |> Enum.min_by(&elem(&1, 1))
  end

  def cost(map, to) do
    map
    |> Enum.map(fn {pos, cnt} -> cnt * abs(pos - to) end)
    |> Enum.sum()
  end

  @doc """
  iex> Crab.p2(Crab.sample())
  {5, 168}
  """
  def p2(list) do
    crabs =
      list
      |> Enum.frequencies()

    {min, max} = Enum.min_max(list)

    min..max
    |> Enum.map(fn pos -> {pos, cost2(crabs, pos)} end)
    |> Enum.min_by(&elem(&1, 1))
  end

  def cost2(map, to) do
    map
    |> Enum.map(fn {pos, cnt} -> cnt * geo(abs(pos - to)) end)
    |> Enum.sum()
  end

  def geo(n), do: Integer.floor_div(n * (n + 1), 2)

  def sample() do
    [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]
  end
end
