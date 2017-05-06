defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(1), do: {:ok, 1}

  def square(number) when number < 1 or number > 64 do
    { :error, "The requested square must be between 1 and 64 (inclusive)" }
  end
  def square(number) do
    {:ok, num} = square(number - 1)
    {:ok, 2 * num}
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    {:ok, Enum.reduce(1..64, 0, fn(i, acc) ->
      {:ok, num} = square(i)
      acc + num
    end)}
  end
end
