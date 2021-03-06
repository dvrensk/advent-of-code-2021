defmodule Dumbo do
  @doc """
  iex> Dumbo.sample()
  ...> |> Dumbo.p1()
  1656
  """
  def p1(text) do
    1..100
    |> Enum.reduce({0, parse(text)}, fn
      _, {cnt, map} ->
        next = gen(map)
        c = Enum.count(next, fn {_, n} -> n == 0 end)
        {cnt + c, next}
    end)
    |> elem(0)
  end

  @doc """
  iex> Dumbo.sample()
  ...> |> Dumbo.p2()
  195
  """
  def p2(text) do
    p2(parse(text), 0, 0)
  end

  def p2(_map, 100, n), do: n

  def p2(map, _, n) do
    next = gen(map)
    c = Enum.count(next, fn {_, n} -> n == 0 end)
    p2(next, c, n + 1)
  end

  @doc """
  iex> Dumbo.parse(0)
  ...> |> Dumbo.gen() == Dumbo.parse(1)
  true
  iex> Dumbo.parse(1)
  ...> |> Dumbo.gen() == Dumbo.parse(2)
  true
  """
  def gen(old) do
    newish =
      old
      |> Enum.map(fn {pos, n} -> {pos, n + 1} end)
      |> Map.new()

    overnines =
      newish
      |> Enum.map(fn
        {pos, 10} -> pos
        _ -> nil
      end)
      |> Enum.reject(&is_nil/1)

    flashem(newish, overnines)
    |> Enum.map(fn
      {pos, n} when n <= 9 -> {pos, n}
      {pos, _} -> {pos, 0}
    end)
    |> Map.new()
  end

  def flashem(map, []), do: map

  def flashem(map, [rc | rest]) do
    {newmap, newlist} =
      neighbours(rc)
      |> Enum.map(fn pos -> {pos, Map.fetch!(map, pos) + 1} end)
      |> Enum.reduce({map, rest}, fn
        {pos, 10}, {map, rest} -> {Map.put(map, pos, 10), [pos | rest]}
        {pos, n}, {map, rest} -> {Map.put(map, pos, n), rest}
      end)

    flashem(newmap, newlist)
  end

  @doc """
  iex> Dumbo.neighbours({1,0})
  [{0, 0}, {0, 1}, {1, 1}, {2, 0}, {2, 1}]
  """
  def neighbours({r, c}) do
    for rr <- (r - 1)..(r + 1),
        cc <- (c - 1)..(c + 1),
        rr != r || cc != c,
        rr >= 0,
        rr < 10,
        cc >= 0,
        cc < 10,
        do: {rr, cc}
  end

  def parse(n) when is_integer(n), do: parse(sample(n))

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

    Map.new(pairs)
  end

  def sample() do
    """
    5483143223
    2745854711
    5264556173
    6141336146
    6357385478
    4167524645
    2176841721
    6882881134
    4846848554
    5283751526
    """
  end

  def sample(0) do
    """
    5483143223
    2745854711
    5264556173
    6141336146
    6357385478
    4167524645
    2176841721
    6882881134
    4846848554
    5283751526
    """
  end

  def sample(1) do
    """
    6594254334
    3856965822
    6375667284
    7252447257
    7468496589
    5278635756
    3287952832
    7993992245
    5957959665
    6394862637
    """
  end

  def sample(2) do
    """
    8807476555
    5089087054
    8597889608
    8485769600
    8700908800
    6600088989
    6800005943
    0000007456
    9000000876
    8700006848
    """
  end

  def sample(3) do
    """
    0050900866
    8500800575
    9900000039
    9700000041
    9935080063
    7712300000
    7911250009
    2211130000
    0421125000
    0021119000
    """
  end

  def sample(4) do
    """
    2263031977
    0923031697
    0032221150
    0041111163
    0076191174
    0053411122
    0042361120
    5532241122
    1532247211
    1132230211
    """
  end

  def sample(5) do
    """
    4484144000
    2044144000
    2253333493
    1152333274
    1187303285
    1164633233
    1153472231
    6643352233
    2643358322
    2243341322
    """
  end

  def sample(6) do
    """
    5595255111
    3155255222
    3364444605
    2263444496
    2298414396
    2275744344
    2264583342
    7754463344
    3754469433
    3354452433
    """
  end

  def sample(7) do
    """
    6707366222
    4377366333
    4475555827
    3496655709
    3500625609
    3509955566
    3486694453
    8865585555
    4865580644
    4465574644
    """
  end

  def sample(8) do
    """
    7818477333
    5488477444
    5697666949
    4608766830
    4734946730
    4740097688
    6900007564
    0000009666
    8000004755
    6800007755
    """
  end

  def sample(9) do
    """
    9060000644
    7800000976
    6900000080
    5840000082
    5858000093
    6962400000
    8021250009
    2221130009
    9111128097
    7911119976
    """
  end

  def sample(10) do
    """
    0481112976
    0031112009
    0041112504
    0081111406
    0099111306
    0093511233
    0442361130
    5532252350
    0532250600
    0032240000
    """
  end

  def sample(20) do
    """
    3936556452
    5686556806
    4496555690
    4448655580
    4456865570
    5680086577
    7000009896
    0000000344
    6000000364
    4600009543
    """
  end

  def sample(30) do
    """
    0643334118
    4253334611
    3374333458
    2225333337
    2229333338
    2276733333
    2754574565
    5544458511
    9444447111
    7944446119
    """
  end

  def sample(40) do
    """
    6211111981
    0421111119
    0042111115
    0003111115
    0003111116
    0065611111
    0532351111
    3322234597
    2222222976
    2222222762
    """
  end

  def sample(50) do
    """
    9655556447
    4865556805
    4486555690
    4458655580
    4574865570
    5700086566
    6000009887
    8000000533
    6800000633
    5680000538
    """
  end

  def sample(60) do
    """
    2533334200
    2743334640
    2264333458
    2225333337
    2225333338
    2287833333
    3854573455
    1854458611
    1175447111
    1115446111
    """
  end

  def sample(70) do
    """
    8211111164
    0421111166
    0042111114
    0004211115
    0000211116
    0065611111
    0532351111
    7322235117
    5722223475
    4572222754
    """
  end

  def sample(80) do
    """
    1755555697
    5965555609
    4486555680
    4458655580
    4570865570
    5700086566
    7000008666
    0000000990
    0000000800
    0000000000
    """
  end

  def sample(90) do
    """
    7433333522
    2643333522
    2264333458
    2226433337
    2222433338
    2287833333
    2854573333
    4854458333
    3387779333
    3333333333
    """
  end

  def sample(100) do
    """
    0397666866
    0749766918
    0053976933
    0004297822
    0004229892
    0053222877
    0532222966
    9322228966
    7922286866
    6789998766
    """
  end
end
