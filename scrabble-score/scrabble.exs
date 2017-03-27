defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @score_map %{
    1 =>  ~w(A E I O U L N R S T),
    2 =>  ~w(D G),
    3 =>  ~w(B C M P),
    4 =>  ~w(F H V W Y),
    5 =>  ~w(K),
    8 =>  ~w(J X),
    10 => ~w(Q Z)
  }

  @scores for {k,vs} <- @score_map, v <- vs, into: %{}, do: {v,k}

  @spec score(String.t) :: non_neg_integer
  def score(""), do: 0
  def score(word) do
    word
      |> String.trim
      |> String.upcase
      |> String.graphemes
      |> Enum.map(fn x -> @scores[x] end)
      |> Enum.sum
  end

end
