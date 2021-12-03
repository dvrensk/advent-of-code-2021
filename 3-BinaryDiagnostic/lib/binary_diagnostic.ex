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
