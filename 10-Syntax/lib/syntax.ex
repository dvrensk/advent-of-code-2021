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
    |> Enum.sum()
  end

  def score(line), do: score(String.codepoints(line), [])

  def score([], _stack), do: 0

  def score([open | rest], stack) when open in ["(", "[", "{", "<"],
    do: score(rest, [open | stack])

  def score([")" | rest], ["(" | stack]), do: score(rest, stack)
  def score(["]" | rest], ["[" | stack]), do: score(rest, stack)
  def score(["}" | rest], ["{" | stack]), do: score(rest, stack)
  def score([">" | rest], ["<" | stack]), do: score(rest, stack)
  def score([")" | _rest], _stack), do: 3
  def score(["]" | _rest], _stack), do: 57
  def score(["}" | _rest], _stack), do: 1197
  def score([">" | _rest], _stack), do: 25137

  @doc """
  iex> Syntax.sample()
  ...> |> Syntax.p2()
  42
  """
  def p2(_text) do
    42
  end

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
