defmodule SonarSweep do
  @doc """
  iex> SonarSweep.count_increases([1,5,6,4,7])
  3
  """
  def count_increases([a, b | rest]) when a < b do
    1 + count_increases([b | rest])
  end

  def count_increases([_, b | rest]) do
    count_increases([b | rest])
  end

  def count_increases([_]) do
    0
  end

  @doc """
  iex> SonarSweep.count_in_windows([199,200,208,210,200,207,240,269,260,263])
  5
  """
  def count_in_windows(list) do
    list
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> count_increases()
  end
end
