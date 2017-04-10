defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) do
    cond do
      not_positive?([a, b, c]) -> {:error, "all side lengths must be positive" }
      inequality?([a, b, c])   -> {:error, "side lengths violate triangle inequality" }
      equilateral?(a, b, c)    -> {:ok, :equilateral}
      isosceles?(a, b, c)      -> {:ok, :isosceles}
      scalene?(a, b, c)        -> {:ok, :scalene}
    end
  end

  def equilateral?(a, b, c) do
    a == b && b == c
  end

  def isosceles?(a, b, c) do
    a == b || b == c || a == c
  end

  def scalene?(a, b, c) do
     a != b && b != c && c != a
  end

  def not_positive?(sides) do
    Enum.any?(sides, fn i -> i <= 0 end)
  end

  def inequality?(sides) do
    Enum.any?(sides, fn i -> Enum.sum(sides) - i <= i end)
  end
end