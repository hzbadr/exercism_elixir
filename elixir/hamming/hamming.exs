defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2) do
    {:error, "Lists must be the same length"}
  end

  def hamming_distance([], []) do
    {:ok, 0}
  end

  def hamming_distance([t1 | h1], [t2 | h2]) do
    {:ok, count} = hamming_distance(h1, h2)
    count = case t1 == t2 do
      true  -> count
      false -> count + 1
    end
    {:ok, count}
  end
end
