defmodule LanternFish do
  @doc """
  iex> LanternFish.sample()
  ...> |> LanternFish.p1(18)
  26
  iex> LanternFish.sample()
  ...> |> LanternFish.p1(80)
  5934
  """
  def p1(list, 0), do: length(list)

  def p1(list, n) do
    list
    |> Enum.flat_map(fn
      0 -> [6, 8]
      a -> [a - 1]
    end)
    |> p1(n - 1)
  end

  @doc """
  iex> LanternFish.sample()
  ...> |> LanternFish.p2(18)
  26
  iex> LanternFish.sample()
  ...> |> LanternFish.p2(80)
  5934
  iex> LanternFish.sample()
  ...> |> LanternFish.p2(256)
  26984457539
  """
  def p2(list, n) when is_list(list) do
    list
    |> Enum.frequencies()
    |> p2(n)
  end

  def p2(counts, 0), do: Map.values(counts) |> Enum.sum()

  def p2(counts, n) do
    0..8
    |> Enum.map(fn
      8 -> {8, Map.get(counts, 0, 0)}
      6 -> {6, Map.get(counts, 0, 0) + Map.get(counts, 7, 0)}
      n -> {n, Map.get(counts, n + 1, 0)}
    end)
    |> Map.new()
    |> p2(n - 1)
  end

  def sample() do
    [3, 4, 3, 1, 2]
  end
end
