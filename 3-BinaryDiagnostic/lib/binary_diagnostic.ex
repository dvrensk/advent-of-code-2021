defmodule BinaryDiagnostic do
  @doc """
  iex> BinaryDiagnostic.sample()
  ...> |> String.split()
  ...> |> BinaryDiagnostic.ge()
  {22, 9}
  """
  def ge(strings) do
    strings
    |> Enum.map(&String.codepoints/1)
    |> transpose()
    |> Enum.map(&Enum.frequencies/1)
    |> Enum.map(fn %{"0" => a, "1" => b} -> if a > b, do: 0, else: 1 end)
    |> Enum.reduce({0, 0}, fn c, {a, b} -> {a * 2 + c, b * 2 + 1 - c} end)
  end

  @doc """
  iex> BinaryDiagnostic.sample()
  ...> |> String.split()
  ...> |> BinaryDiagnostic.p2()
  {23, 10}
  """
  def p2(strings) do
    [&Kernel.>=/2, &Kernel.</2]
    |> Enum.map(&cull_recursively(strings, &1))
    |> Enum.map(&String.to_integer(&1, 2))
    |> List.to_tuple()
  end

  def cull_recursively(list, op, pos \\ 0)
  def cull_recursively([a], _op, _pos), do: a

  def cull_recursively(list, op, pos) do
    cull(list, op, pos)
    |> cull_recursively(op, pos + 1)
  end

  @doc """
  iex> ["10110", "10111", "10101"]
  ...> |> BinaryDiagnostic.cull(&Kernel.>=/2, 3)
  ["10110", "10111"]
  """
  def cull(list, op, pos) do
    %{"0" => zeros, "1" => ones} =
      list
      |> Enum.group_by(&String.at(&1, pos))

    if op.(length(ones), length(zeros)), do: ones, else: zeros
  end

  def transpose(rows), do: rows |> List.zip() |> Enum.map(&Tuple.to_list/1)

  def sample() do
    """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    """
  end
end
