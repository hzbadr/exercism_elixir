defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """

  @prackets %{"{" => "}", "[" => "]", "(" => ")"}

  @spec check_brackets(String.t) :: boolean
  def check_brackets("") do
    true
  end

  def check_brackets(str) do
    String.split(str, "")
    |> closed?
  end

  defp closed?([h | t]) do
    cond do
      open_pracket?(h) -> closed?(t, Map.get(@prackets, h))
      true -> closed?(t)
    end
  end

  defp closed?([], _), do: false
  defp closed?([h | t], p) do
    cond do
      h == p -> true
      non_match_close?(h) -> false
      open_pracket?(h) -> closed?(t, Map.get(@prackets, h))
      true -> closed?(t, Map.get(@prackets, p))
    end
  end

  def non_match_close?(h) do
    Map.values(@prackets)
    |> Enum.member?(h)
  end

  defp open_pracket?(h) do
    Map.get(@prackets, h, false)
  end
end