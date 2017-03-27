defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  TODO HZ: Still not perfect!

  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    case valid(strand) and valid(nucleotide) do
      true -> Enum.reduce(strand, 0, fn c, count -> if c == nucleotide do count + 1 else count end end)
      false -> raise ArgumentError
    end
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    case valid(strand) do
      true -> %{?A => count(strand, ?A), ?T => count(strand, ?T), ?C => count(strand, ?C), ?G => count(strand, ?G)}
      false -> raise ArgumentError
    end
  end

  defp valid(s) when is_integer(s) do
    Enum.member?(@nucleotides, s)
  end

  defp valid(s) when is_list(s)do
    s
    |> Enum.uniq
    |> Enum.all?(fn c -> Enum.member?(@nucleotides, c) end)
  end
end
