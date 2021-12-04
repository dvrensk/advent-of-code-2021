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
    |> draw_balls_until_first_winner(balls)
  end

  @doc """
  iex> Bingo.sample()
  ...> |> String.split("\\n\\n", trim: true)
  ...> |> Bingo.last()
  {148, 13}
  """
  def last([balls | boards]) do
    balls =
      balls
      |> String.split(",", trim: true)

    boards
    |> Enum.map(&twoboards/1)
    |> draw_balls_until_last_winner(balls)
  end

  def twoboards(str) do
    a =
      str
      |> String.split()
      |> Enum.chunk_every(5)

    b = Enum.zip(a) |> Enum.map(&Tuple.to_list/1)
    {a, b}
  end

  def draw_balls_until_first_winner(boards, [ball | rest]) do
    new_boards =
      boards
      |> Enum.map(&draw_ball(ball, &1))

    winner =
      new_boards
      |> Enum.find(&bingo?/1)

    if winner do
      {value(winner), String.to_integer(ball)}
    else
      draw_balls_until_first_winner(new_boards, rest)
    end
  end

  def value(board) do
    board
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  def draw_balls_until_last_winner(boards, [ball | rest]) do
    new_boards =
      boards
      |> Enum.map(fn {a, b} -> {draw_ball(ball, a), draw_ball(ball, b)} end)

    new_boards
    |> Enum.reject(fn {a, b} -> bingo?(a) || bingo?(b) end)
    |> case do
      [] -> {value(hd(new_boards) |> elem(0)), String.to_integer(ball)}
      playing -> draw_balls_until_last_winner(playing, rest)
    end
  end

  def draw_ball(ball, board) do
    filter = &Kernel.==(ball, &1)

    board
    |> Enum.map(&Enum.reject(&1, filter))
  end

  def bingo?(board) do
    board
    |> Enum.any?(fn
      [] -> true
      _ -> false
    end)
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
