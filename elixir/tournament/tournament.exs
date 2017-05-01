defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @result %{
    "win" => "W",
    "loss" => "L",
    "draw" => "D"
  }
  @oponent %{
    "win" => "L",
    "loss" => "W",
    "draw" => "D"
  }

  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.map(&parse/1)
    |> Enum.filter(&(&1))
    |> Enum.reduce(%{}, fn(match, accum)->
      Enum.reduce(match, accum, fn({t, s}, acc) ->
        ts = Map.get(acc, t, %{"L" => 0, "D" => 0, "W" => 0, "score" => 0})
        current = Map.get(ts, s, 0)
        ts = Map.put(ts, s, current+1)
        Map.put(acc, t, ts)
      end)
    end)
    |> Enum.map(&calc_score/1)
    |> Enum.sort_by(fn({_, %{"score" => score}})-> -score end)
    |> Enum.reduce("Team                           | MP |  W |  D |  L |  P", &(format(&1, &2)))
  end

  defp parse([t1, t2, result]) do
    case @result[result] do
      nil -> nil
      _ -> %{t1 => @result[result], t2 => @oponent[result]}
    end
  end
  defp parse([_ | _]) do
    nil
  end
  defp parse(input) do
    parse(String.split(input, ";"))
  end

  defp format({team, %{"W"=> win, "L" => loss, "D" => draw, "score" => score}}, result) do
    """
    #{result}
    #{String.pad_trailing(team, 31)}|  #{win+loss+draw} |  #{win} |  #{draw} |  #{loss} |  #{score}
    """ |> String.trim
  end

  defp calc_score({team, %{"W"=> win, "L" => loss, "D" => draw}}) do
    score = draw + (3 * win)
    {team, %{"W"=> win, "L" => loss, "D" => draw, "score" => score}}
  end

end
