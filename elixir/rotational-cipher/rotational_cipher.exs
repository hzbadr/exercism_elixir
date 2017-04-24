defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    to_charlist(text)
    |> Enum.map(fn x ->
      cond do
        x >= ?A && x <= ?Z -> ?A + rem(x-?A+shift, 26)
        x >= ?a && x <= ?z -> ?a + rem(x-?a+shift, 26)
        true -> x
      end
    end)
    |> List.to_string
  end
end
