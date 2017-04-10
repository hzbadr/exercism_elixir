defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    Enum.sum(for x <- 0..limit-1,
             Enum.any?(factors, fn(y) -> rem(x, y) == 0 end),
             do: x)
  end
end