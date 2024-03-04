defmodule AOC do
  def hello do
    :world
  end

  def getDay(day) do
    HTTPoison.get!("https://adventofcode.com/2023/day/#{day}/input", %{}, hackney: [cookie: ["session=#{getSession()}"]]).body()
    |> String.split("\n")
    |> List.delete_at(-1)
  end

  defp getSession() do
    File.read!("session")
  end
end
