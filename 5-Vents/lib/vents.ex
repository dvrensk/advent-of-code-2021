defmodule Vents do
  @doc """
  iex> Vents.sample()
  ...> |> String.split("\\n", trim: true)
  ...> |> Vents.count(2)
  5
  iex> Vents.sample()
  ...> |> String.split("\\n", trim: true)
  ...> |> Vents.count(2, true)
  12
  """
  def count(list, minimum, keep_all \\ false) do
    list
    |> Enum.map(fn row ->
      Regex.scan(~r/\d+/, row)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.filter(fn [x1, y1, x2, y2] -> keep_all || x1 == x2 || y1 == y2 end)
    |> Enum.map(&expand/1)
    |> List.flatten()
    |> Enum.frequencies()
    |> Enum.count(fn {_, c} -> c >= minimum end)
  end

  def expand([x, y1, x, y2]) do
    [y1, y2] = Enum.sort([y1, y2])
    Enum.map(y1..y2, fn y -> {x, y} end)
  end

  def expand([x1, y, x2, y]) do
    [x1, x2] = Enum.sort([x1, x2])
    Enum.map(x1..x2, fn x -> {x, y} end)
  end

  def expand([x1, y1, x2, y2]) do
    Enum.zip(
      if(x1 > x2, do: x1..x2//-1, else: x1..x2),
      if(y1 > y2, do: y1..y2//-1, else: y1..y2)
    )
  end

  def sample() do
    """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """
  end
end
