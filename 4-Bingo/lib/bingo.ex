defmodule Bingo do
  @doc """
  iex> Bingo.sample()
  ...> |> String.split("\\n\\n", trim: true)
  ...> |> Bingo.top_score()
  {188, 24}
  """
  def top_score([balls | boards]) do
    balls =
      balls
      |> String.split(",", trim: true)

    boards
    |> Enum.map(&twoboards/1)
    |> List.foldl([], fn {a, b}, acc -> [a, b | acc] end)
    |> draw_balls(balls)
  end

  def twoboards(str) do
    a =
      str
      |> String.split()
      |> Enum.chunk_every(5)

    b = Enum.zip(a) |> Enum.map(&Tuple.to_list/1)
    {a, b}
  end

  def draw_balls(boards, [ball | rest]) do
    new_boards = draw_ball(ball, boards)

    bingo =
      new_boards
      |> Enum.find(
        &Enum.any?(&1, fn
          [] -> true
          _ -> false
        end)
      )

    if bingo do
      value =
        bingo
        |> List.flatten()
        |> Enum.map(&String.to_integer/1)
        |> Enum.sum()

      {value, String.to_integer(ball)}
    else
      draw_balls(new_boards, rest)
    end
  end

  def draw_ball(ball, boards) do
    boards
    |> Enum.map(&draw_ball1(ball, &1))
  end

  def draw_ball1(ball, board) do
    board
    |> Enum.map(
      &Enum.reject(&1, fn
        ^ball -> true
        _ -> false
      end)
    )
  end

  def sample() do
    """
    7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

    22 13 17 11  0
     8  2 23  4 24
    21  9 14 16  7
     6 10  3 18  5
     1 12 20 15 19

     3 15  0  2 22
     9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6

    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5
     2  0 12  3  7
    """
  end
end
