defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t}
  def generate(coins, target) do
    coins = coins
      |> Enum.filter(fn(x) -> x <= target end)
      |> Enum.reverse
    0..length(coins)
    |> Enum.map(fn x ->
      coins
      |> Enum.slice(x, length(coins))
      |> generate(target, [])
    end)
    |> Enum.filter(fn
      {:ok, _} -> true
      {:error, _} -> false
    end)
    |> Enum.min_by(fn {:ok, l} -> length(l) end, fn ->  {:error, "cannot change"} end)
  end

  defp generate(_, 0, acc)  do
    {:ok, acc}
  end
  defp generate([h | t], target, acc) when h <= target do
    case generate([h | t], target - h, [h | acc]) do
      {:ok, acc} -> {:ok, acc}
      {:error, _} -> generate(t, target, acc)
    end
  end
  defp generate([h | t], target, acc) when h > target do
    generate(t, target, acc)
  end
  defp generate([], _, _)  do
    {:error, "cannot change"}
  end

end
