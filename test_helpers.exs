
  def input(path \\ "input.txt"), do: File.read!(path)
  def input_words(path \\ "input.txt"), do: input(path) |> String.split(~r/\s+/, trim: true)
  def input_lines(path \\ "input.txt"), do: input(path) |> String.split("\n", trim: true)
  def input_paragraphs(path \\ "input.txt"), do: input(path) |> String.split("\n\n", trim: true)

  def input_ints(path \\ "input.txt"),
    do:
      input(path)
      |> (&Regex.scan(~r/-?\d+/, &1)).()
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)

  def assert_eq(a, b), do: assert(a == b)
end
