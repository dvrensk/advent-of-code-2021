defmodule SmokeBasin do
  @doc """
  iex> SmokeBasin.p1(SmokeBasin.sample())
  15
  """
  def p1(text) do
    {map, _max_r, _max_c} = parse(text)

    map
    |> Enum.filter(&local_min?(&1, map))
    |> Enum.map(fn {_, h} -> h + 1 end)
    |> Enum.sum()
  end

  @doc """
  iex> SmokeBasin.p2(SmokeBasin.sample())
  1134
  """
  def p2(text) do
    {map, _max_r, _max_c} = parse(text)

    map
    |> Enum.filter(&local_min?(&1, map))
    |> Enum.map(&basin(&1, map))
    |> Enum.sort_by(fn list -> -length(list) end)
    |> Enum.take(3)
    |> List.foldl(1, fn b, acc -> length(b) * acc end)
  end

  def basin({pos, _}, map), do: basin(MapSet.new([pos]), [pos], map)

  def basin(set, [], _), do: MapSet.to_list(set)

  def basin(set, [pos0 | rest], map) do
    more =
      adjacent(pos0)
      |> Enum.reject(fn pos -> MapSet.member?(set, pos) || Map.get(map, pos, 9) > 8 end)

    basin(MapSet.union(set, MapSet.new(more)), more ++ rest, map)
  end

  def local_min?({pos, h} = _node, map) do
    adjacent(pos)
    |> Enum.all?(fn pos -> Map.get(map, pos, 9) > h end)
  end

  def adjacent({r, c}) do
    [{-1, 0}, {+1, 0}, {0, -1}, {0, +1}]
    |> Enum.map(fn {dr, dc} -> {r + dr, c + dc} end)
  end

  def parse(string) do
    pairs =
      string
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {row, r} ->
        row
        |> String.codepoints()
        |> Enum.with_index()
        |> Enum.map(fn {square, c} ->
          {{r, c}, String.to_integer(square)}
        end)
      end)

    map = Map.new(pairs)
    {{r, c}, _} = pairs |> Enum.reverse() |> hd()
    {map, r, c}
  end

  def sample() do
    """
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    """
  end
end
