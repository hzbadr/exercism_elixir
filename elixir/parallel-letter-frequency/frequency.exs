defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  # Thanks to https://github.com/ebiven/exercism/blob/master/elixir/parallel-letter-frequency/frequency.exs

  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    results = texts
              |> Enum.join
              |> String.downcase
              |> String.replace(~r/[^(.(?!\p{L}))]/u, "")
              |> String.split("", trim: true)
              |> do_chunk(workers)
              |> Enum.map(&(Task.async(fn -> do_count(&1) end)))
              |> Task.yield_many(5000)
              |> Enum.map(fn {task, res} -> res || Task.shutdown(task, :brutal_kill) end)

    for {:ok, value} <- results do
      value
    end
    |> accumulate(%{})
  end

  defp do_chunk([], _), do: []
  defp do_chunk(letters, workers) do
    c = Enum.count(letters) / workers |> Float.ceil |> round
    Enum.chunk(letters, c, c, [])
  end
  defp do_count(letters) do
    Enum.reduce(letters, %{}, fn(letter, acc)->
      Map.update(acc, letter, 1, &(&1 + 1))
    end)
  end
  defp accumulate([], acc), do: acc
  defp accumulate([head | tail], acc) do
    acc = Enum.reduce(head, acc, fn({l,c}, a) -> Map.update(a, l, c, &(&1+c)) end)
    accumulate(tail, acc)
  end
end
