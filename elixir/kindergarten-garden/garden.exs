defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @plants %{"R" => :radishes, "C" => :clover, "G" => :grass, "V" => :violets}
  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]) do
    info_string
    |> String.split("\n")
    |> Enum.reduce(%{}, fn(e, acc)-> info(String.split_at(e, 2), student_names, acc) end)
  end

  def info({"",""}, [s1, students], acc) do
    Map.put(acc, s1, {})
  end
  def info(_, [], acc), do: acc
  def info({a, b}, [s1 | students], acc) do
    info(String.split_at(b, 2), students, Map.update(acc, s1, convert(a), fn(e) -> convert(e, a) end))
  end

  def convert(str) do
    {@plants[String.at(str, 0)], @plants[String.at(str, 1)]}
  end
  def convert(_, "") do
    {}
  end
  def convert(e, str) do
    e
    |> Tuple.append(@plants[String.at(str, 0)])
    |> Tuple.append(@plants[String.at(str, 1)])
  end
end
