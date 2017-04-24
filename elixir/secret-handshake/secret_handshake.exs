defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  require Bitwise

  @actions ["wink", "double blink", "close your eyes", "jump"]
  @bits [1,2,4,8]

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    @bits
    |> Enum.map(fn(x) -> Bitwise.&&&(code, x) end)
    |> Enum.zip(@actions)
    |> Enum.reduce([], fn({n, s}, acc) ->
      cond do
        n == 0 -> acc
        true -> [s | acc]
      end
    end)
    |> reverse_if(code)
  end

  defp reverse_if(list, code) do
    case Bitwise.&&&(code, 16)  do
      0 -> Enum.reverse(list)
      _ -> list
    end
  end
end
