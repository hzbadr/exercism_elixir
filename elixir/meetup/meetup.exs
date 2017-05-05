defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """
  @weekdays [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
  # @weeks %{
  #   first: 1, second: 2, third: 3, fourth: 4, last: 5, teenth: 1
  # }
  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    weeks = month_days(year, month)
    |> Enum.chunk(7, 7, [])
    day = find_day(weeks, weekday, schedule)
    {year, month, day}

  end

  defp month_days(year, month) do
    {:ok, month_first_day} = Date.new(year, month, 1)
    days_in_month = Date.days_in_month(month_first_day)
    Enum.reduce(1..days_in_month, [], fn(d, acc)->
      {:ok, date} = Date.new(year, month, d)
      acc ++ [Enum.at(@weekdays, Date.day_of_week(date) - 1)]
    end)
  end

  defp find_day(weeks, weekday, :first) do
    week = Enum.at(weeks, 0)
    Enum.find_index(week, fn(day) -> day == weekday end) + 1
  end
  defp find_day(weeks, weekday, :second) do
    7 + find_day(weeks, weekday, :first)
  end
  defp find_day(weeks, weekday, :third) do
    7 + find_day(weeks, weekday, :second)
  end
  defp find_day(weeks, weekday, :fourth) do
    7 + find_day(weeks, weekday, :third)
  end
  defp find_day(weeks, weekday, :teenth) do
    Enum.find([find_day(weeks, weekday, :third),
    find_day(weeks, weekday, :second)], fn(x) ->
      x > 12 && x < 20
    end)

  end
  defp find_day(weeks, weekday, :last) do
    cond do
      day_in_last_week(weeks, weekday) -> 7 + find_day(weeks, weekday, :fourth)
      true -> find_day(weeks, weekday, :fourth)
    end
  end

  defp day_in_last_week(weeks, weekday) do
    length(weeks) == 5 && Enum.find(Enum.at(weeks, 4), fn(d)-> d == weekday end)
  end
end
