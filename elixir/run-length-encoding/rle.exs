defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode("") do
    ""
  end
  def encode(string) do
    string
    |> String.graphemes
    |> Enum.reduce([], fn(e, res) ->
      case List.last(res) do
        {^e, x} -> List.replace_at(res, -1, {e, x + 1})
        _ -> res = res ++ [{e, 1}]
      end
    end)
    |> Enum.reduce("", fn({x, y}, res) -> res <> to_string(y) <> x end)
  end

  def decode([_, "", x]) do x end
  def decode([_,  n, x]) do String.duplicate(x, String.to_integer(n)) end

  @spec decode(String.t) :: String.t
  def decode([_, "", x]) do x end
  def decode(string) do
    Regex.scan(~r/(\d*)(\w)/, string)
    |> Enum.reduce("", fn c, s -> s <> decode(c) end)
  end
end