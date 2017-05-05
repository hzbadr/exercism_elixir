defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: {}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem), do: {elem, list}

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length({}), do: 0
  def length({_}), do: 1
  def length({_, t}) do
    1 + __MODULE__.length(t)
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list), do: list == {}

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({}), do: {:error, :empty_list}
  def peek({t}), do: {:ok, t}
  def peek({t, _}), do: {:ok, t}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({}), do: {:error, :empty_list}
  def tail({t}), do: {:ok, t}
  def tail({_, t}), do: {:ok, t}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({}), do: {:error, :empty_list}
  def pop({h}), do: {:ok, h, {}}
  def pop({h, t}), do: {:ok, h, t}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list([]), do: {}
  def from_list([h]), do: {h}
  def from_list([h | t]), do: push(from_list(t), h)

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list({}), do: []
  def to_list({h}), do: [h]
  def to_list({h, t}), do: [h | to_list(t)]

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse({h, t}), do: reverse(t, {h})
  def reverse({h}, acc), do: push(acc, h)
  def reverse({h, t}, acc), do: reverse(t, push(acc, h))
end
