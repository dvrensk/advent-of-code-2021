defmodule SevenSegments do
  @doc """
  iex> SevenSegments.p1(SevenSegments.sample())
  26
  """
  def p1(text) do
    Regex.replace(~r/.*? \| /, text, "")
    |> String.split()
    |> Enum.filter(fn s -> String.length(s) in [2, 3, 4, 7] end)
    |> Enum.count()
  end

  @doc """
  iex> SevenSegments.p2(SevenSegments.sample())
  61229
  """
  def p2(text) do
    text
    |> String.split("\n", trim: true)
    |> Enum.map(&p21/1)
    |> Enum.sum()
  end

  @doc """
  iex> SevenSegments.sample()
  ...> |> String.split("\\n", trim: true)
  ...> |> hd()
  ...> |> SevenSegments.p21()
  8394
  """
  def p21(line) do
    {ten, riddle} =
      Regex.scan(~r/\w+/, line)
      |> Enum.map(fn [s] -> String.codepoints(s) |> MapSet.new() end)
      |> Enum.split(10)

    {one, rest} = size(2, ten)
    {four, rest} = size(4, rest)
    {seven, rest} = size(3, rest)
    {eight, rest} = size(7, rest)

    almost_nine = MapSet.union(four, seven)
    {nine, rest} = remove(rest, &MapSet.subset?(almost_nine, &1))

    almost_six = MapSet.difference(eight, one)
    {six, rest} = remove(rest, &MapSet.subset?(almost_six, &1))

    {zero, rest} = size(6, rest)

    e = MapSet.difference(eight, nine)

    five = MapSet.difference(six, e)
    rest = Enum.reject(rest, fn e -> MapSet.equal?(e, five) end)

    # We're missing 2 & 3. Only 2 has e.
    {two, [three]} = remove(rest, &MapSet.subset?(e, &1))

    all = [zero, one, two, three, four, five, six, seven, eight, nine]

    riddle
    |> Enum.map(&Enum.find_index(all, fn e -> MapSet.equal?(e, &1) end))
    |> List.foldl(0, fn n, a -> a * 10 + n end)
  end

  def size(n, list) do
    remove(list, fn s -> MapSet.size(s) == n end)
  end

  @doc """
  iex> SevenSegments.remove([1,2,3,4], fn a -> a == 3 end)
  {3, [1, 2, 4]}
  """
  def remove(enumerable, predicate) do
    %{true => [target], false => rest} =
      enumerable
      |> Enum.group_by(predicate)

    {target, rest}
  end

  def sample() do
    """
    be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
    edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
    fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
    fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
    aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
    fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
    dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
    bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
    egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
    gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
    """
  end
end
