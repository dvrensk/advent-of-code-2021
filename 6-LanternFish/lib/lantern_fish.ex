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

  def sample() do
    [3, 4, 3, 1, 2]
  end
end
