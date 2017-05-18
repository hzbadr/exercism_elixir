defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> Enum.flat_map(&String.graphemes(&1))
    |> Enum.filter_map(fn(w)->
      String.trim(w) != ""
    end, fn(w)->
      w
      |> String.replace(~r/,|\.|[0-9]/, "")
      |> String.downcase
    end)
    |> Enum.reduce(%{}, fn(word, acc)->
      Task.async(fn->
        Map.update(acc, word, 1, &(&1 + 1))
      end)
    end)
    |> Enum.map(&(Task.await(&1, 10000)))
  end
end
