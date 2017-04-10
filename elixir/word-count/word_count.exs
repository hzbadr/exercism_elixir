defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    Enum.reduce(normalized_split(sentence), %{}, fn(word, result) -> count(String.downcase(word), result) end)
  end

  def count(word, result) do
    Map.put(result, word, Map.get(result, word, 0) + 1)
  end

  def normalize(sentence) do
    sentence
    |> String.replace(~r/,|!|:|@|\$|%|\^|&/, "")
    |> String.replace(~r/\s+/, " ")
  end

  def normalized_split(sentence) do
    sentence
    |> normalize
    |> String.split(~r/\s|_/)
  end
end