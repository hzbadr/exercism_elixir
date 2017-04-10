defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    normalized = normalize(sentence)
    unique = Enum.uniq(normalized)
    Enum.count(unique) == Enum.count(normalized)
  end

  def normalize(sentence) do
    sentence
    |> String.downcase
    |> String.replace(~r/\s|-/u, "")
    |> to_charlist
  end

end