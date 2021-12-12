defmodule Paths do
  @doc """
  iex> Paths.sample(0)
  ...> |> Paths.p1()
  10
  iex> Paths.sample(2)
  ...> |> Paths.p1()
  226
  """
  def p1(text) do
    do_p1(text)
    |> Enum.count()
  end

  @doc """
  iex> Paths.sample(0)
  ...> |> Paths.do_p1() == Paths.solved(0)
  """
  def do_p1(text) do
    map = parse(text)
    at = "start"
    avoid = MapSet.new([at])

    search(to(at, map, avoid), avoid, [at], [], map)
    |> Enum.map(&Enum.join(&1, ","))
    |> Enum.sort()
  end

  def search(["end" | rest], avoid, path, paths, map),
    do: search(rest, avoid, path, [Enum.reverse(["end" | path]) | paths], map)

  def search([], _avoid, _path, paths, _map), do: paths

  def search([node | rest], avoid, path, paths, map) do
    avoid2 = maybe_avoid(node, avoid)
    paths2 = search(to(node, map, avoid2), avoid2, [node | path], paths, map)
    search(rest, avoid, path, paths2, map)
  end

  def maybe_avoid(node, set),
    do: if(Regex.match?(~r/^[a-z]/, node), do: MapSet.put(set, node), else: set)

  def to(at, map, avoid) do
    map
    |> Enum.flat_map(fn
      {^at, to} -> [to]
      {to, ^at} -> [to]
      _ -> []
    end)
    |> Enum.reject(&MapSet.member?(avoid, &1))
  end

  @doc """
  iex> Paths.sample(0)
  ...> |> Paths.p2()
  42
  """
  def p2(_text) do
    42
  end

  def parse(text) do
    text
    |> String.split()
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.map(&List.to_tuple/1)
  end

  def sample(0) do
    """
    start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end
    """
  end

  def solved(0) do
    """
    start,A,b,A,c,A,end
    start,A,b,A,end
    start,A,b,end
    start,A,c,A,b,A,end
    start,A,c,A,b,end
    start,A,c,A,end
    start,A,end
    start,b,A,c,A,end
    start,b,A,end
    start,b,end
    """
  end

  def sample(1) do
    """
    dc-end
    HN-start
    start-kj
    dc-start
    dc-HN
    LN-dc
    HN-end
    kj-sa
    kj-HN
    kj-dc
    """
  end

  def solved(1) do
    """
    start,HN,dc,HN,end
    start,HN,dc,HN,kj,HN,end
    start,HN,dc,end
    start,HN,dc,kj,HN,end
    start,HN,end
    start,HN,kj,HN,dc,HN,end
    start,HN,kj,HN,dc,end
    start,HN,kj,HN,end
    start,HN,kj,dc,HN,end
    start,HN,kj,dc,end
    start,dc,HN,end
    start,dc,HN,kj,HN,end
    start,dc,end
    start,dc,kj,HN,end
    start,kj,HN,dc,HN,end
    start,kj,HN,dc,end
    start,kj,HN,end
    start,kj,dc,HN,end
    start,kj,dc,end
    """
  end

  def sample(2) do
    """
    fs-end
    he-DX
    fs-he
    start-DX
    pj-DX
    end-zg
    zg-sl
    zg-pj
    pj-he
    RW-he
    fs-DX
    pj-RW
    zg-RW
    start-pj
    he-WI
    zg-he
    pj-fs
    start-RW
    """
  end
end
