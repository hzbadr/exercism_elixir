defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0) do
    raise("Error")
  end
  def nth(1) do
    2
  end
  def nth(count) do
    nth(2, count, [2])
  end

  def nth(n, 1, _) do
    (n - 1)
  end

  def nth(n, count, primes) do
    case prime?(n, primes) do
      true -> nth(n+1, count-1, primes ++ [n])
      _ -> nth(n+1, count, primes)
    end
  end

  def prime?(n, primes) do
    !Enum.any?((primes), fn x -> rem(n, x) == 0 end)
  end

end