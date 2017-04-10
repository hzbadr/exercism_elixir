defmodule Bob do
  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"
      asking?(input) -> "Sure."
      yelling?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  def contains(input, "tom") do
    input
    |> String.downcase
    |> String.contains? "tom"
  end

  def yelling?(input) do
    (input == String.upcase(input)) &&  (String.match?(input, ~r/\p{L}/))
  end

  def asking?(input) do
    String.last(input) == "?"
  end

  def silence?(input) do
    String.strip(input) == ""
  end
end