defmodule Syntax do
  @doc """
  iex> Syntax.sample()
  ...> |> Syntax.p1()
  26397
  """
  def p1(text) do
    text
    |> String.split("\n", trim: true)
    |> Enum.map(&score/1)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  def score(line), do: score(String.codepoints(line), [])

  def score([], stack), do: {0, stack}

  def score([open | rest], stack) when open in ["(", "[", "{", "<"],
    do: score(rest, [open | stack])

  def score([")" | rest], ["(" | stack]), do: score(rest, stack)
  def score(["]" | rest], ["[" | stack]), do: score(rest, stack)
  def score(["}" | rest], ["{" | stack]), do: score(rest, stack)
  def score([">" | rest], ["<" | stack]), do: score(rest, stack)
  def score([")" | _rest], stack), do: {3, stack}
  def score(["]" | _rest], stack), do: {57, stack}
  def score(["}" | _rest], stack), do: {1197, stack}
  def score([">" | _rest], stack), do: {25137, stack}

  @doc """
  iex> Syntax.sample()
  ...> |> Syntax.p2()
  288957
  """
  def p2(text) do
    scores =
      text
      |> String.split("\n", trim: true)
      |> Enum.map(&score/1)
      |> Enum.filter(fn {s, _} -> s == 0 end)
      |> Enum.map(&elem(&1, 1))
      |> Enum.map(&score2(&1, 0))
      |> Enum.sort()

    Enum.at(scores, div(length(scores) - 1, 2))
  end

  def score2([], acc), do: acc
  def score2(["(" | rest], acc), do: score2(rest, acc * 5 + 1)
  def score2(["[" | rest], acc), do: score2(rest, acc * 5 + 2)
  def score2(["{" | rest], acc), do: score2(rest, acc * 5 + 3)
  def score2(["<" | rest], acc), do: score2(rest, acc * 5 + 4)

  def sample() do
    """
    [({(<(())[]>[[{[]{<()<>>
    [(()[<>])]({[<{<<[]>>(
    {([(<{}[<>[]}>{[]{[(<()>
    (((({<>}<{<{<>}{[]{[]{}
    [[<[([]))<([[{}[[()]]]
    [{[{({}]{}}([{[{{{}}([]
    {<[[]]>}<{[{[{[]{()[[[]
    [<(<(<(<{}))><([]([]()
    <{([([[(<>()){}]>(<<{{
    <{([{{}}[<[[[<>{}]]]>[]]
    """
  end
end
