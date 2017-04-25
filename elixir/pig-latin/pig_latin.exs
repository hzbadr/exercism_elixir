defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @vowels ~w[a e i o u xr yt]
  @consonants_2 ~w[qu ch th]
  @consonants_3 ~w[squ thr sch]

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map(fn(word) ->
      cond do
        vowel?(word) ->
         word <> "ay"
        consonant_3?(word) ->
          {y, x} = String.split_at(word,3)
          x <> y <> "ay"
        consonant_2?(word) ->
          {y, x} = String.split_at(word,2)
          x <> y <> "ay"
        true ->
          {y, x} = String.split_at(word,1)
          x <> y <> "ay"
      end
    end)
    |> Enum.join(" ")
  end

  def vowel?(word) do
    String.starts_with?(word, @vowels)
  end

  def consonant_3?(word) do
    String.starts_with?(word, @consonants_3)
  end

  def consonant_2?(word) do
    String.starts_with?(word, @consonants_2)
   end
end
