defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    sorted_base = sorted_charlist(base)
    Enum.filter(candidates, fn x ->
        not_the_same_word(base, x) && sorted_base == sorted_charlist(x)
      end)
  end

  defp not_the_same_word(base, x) do
    String.downcase(base) != String.downcase(x)
  end
  defp sorted_charlist(x) do
    x
    |> String.downcase
    |> to_char_list
    |> Enum.sort
  end
end