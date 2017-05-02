defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten([h | t]) do
    flatten(h) ++ flatten(t)
  end
  def flatten(nil), do: []
  def flatten([]), do: []
  def flatten(e), do: [e]

end
