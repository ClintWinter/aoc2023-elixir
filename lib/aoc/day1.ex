defmodule Day1 do
  @number_map %{
    one: "1",
    two: "2",
    three: "3",
    four: "4",
    five: "5",
    six: "6",
    seven: "7",
    eight: "8",
    nine: "9",
  }

  def part1() do
    AOC.getDay(1)
    |> getResult()
  end

  def part2() do
    AOC.getDay(1)
    |> Enum.map(&numbers_to_digits/1)
    |> getResult()
  end

  defp getResult(list) do
    list
    |> Enum.map(&get_outside_numbers/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  defp get_outside_numbers(line) do
    first = List.first(Regex.run(~r/(\d)/, line))
    last = List.first(Regex.run(~r/(\d)/, String.reverse(line)))
    first <> last
  end

  defp numbers_to_digits(line) do
    String.replace(
      line,
      Map.keys(@number_map) |> Enum.map(&Atom.to_string/1),
      fn match -> @number_map[String.to_atom(match)] end
    )
  end
end
