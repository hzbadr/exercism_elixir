defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do
    Enum.to_list(?a..?z) -- normalize(sentence)
    |> Enum.empty?
  end

  def normalize(sentence) do
    sentence
    |> String.downcase
    |> String.replace(~r/[^A-z\s]/u, "") #remove non-ascii chars
    |> to_charlist
  end
end