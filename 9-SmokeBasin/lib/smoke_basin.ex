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

  def local_min?({{r, c}, h} = node, map) do
    [
      {-1, 0},
      {+1, 0},
      {0, -1},
      {0, +1}
    ]
    |> Enum.all?(fn
      {dr, dc} ->
        val = Map.get(map, {r + dr, c + dc})
        is_nil(val) || val > h
    end)
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
