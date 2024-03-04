defmodule Day2 do
  @maxes %{red: 12, green: 13, blue: 14}
  defstruct [:id, red: 0, blue: 0, green: 0]

  def part1() do
    AOC.getDay(2)
    |> Enum.map(&parse_game/1)
    |> Enum.filter(&game_possible?/1)
    |> Enum.reduce(0, fn game, acc -> game.id + acc end)
  end

  def part2() do
    AOC.getDay(2)
    |> Enum.map(&parse_game/1)
    |> Enum.map(&cube_power/1)
    |> Enum.sum()
  end

  defp game_possible?(game_result) do
    game_result.games
    |> Enum.all?(fn game -> game.count <= @maxes[String.to_atom(game.color)] end)
  end

  defp parse_game(line) do
    [id, games] = Regex.run(~r/Game (\d+): (.*)/, line, capture: :all_but_first)

    parsed = String.split(games, ~r/[ ,;]+/, trim: true)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [count, color] -> %{count: String.to_integer(count), color: color} end)

    %{id: String.to_integer(id), games: parsed}
  end

  defp cube_power(game) do
    game.games
    |> Enum.reduce(%{red: 0, green: 0, blue: 0}, fn item, acc ->
      case item.color do
        "red" -> %{acc | red: max(acc.red, item.count)}
        "green" -> %{acc | green: max(acc.green, item.count)}
        "blue" -> %{acc | blue: max(acc.blue, item.count)}
      end
    end)
    |> Map.values()
    |> Enum.product()
  end
end
