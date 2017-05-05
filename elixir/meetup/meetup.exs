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
    day = find_day(weeks, weekday, schedule) + 1
    {year, month, day}

  end

  def month_days(year, month) do
    {:ok, month_first_day} = Date.new(year, month, 1)
    days_in_month = Date.days_in_month(month_first_day)
    Enum.reduce(1..days_in_month, [], fn(d, acc)->
      {:ok, date} = Date.new(year, month, d)
      acc ++ [Enum.at(@weekdays, Date.day_of_week(date) - 1)]
    end)
  end

  def find_day(week, weekday) do
    Enum.find_index(week, fn(day) -> day == weekday end)
  end

  def find_day(weeks, weekday, :first) do
    week = Enum.at(weeks, 0)
    Enum.find_index(week, fn(day) -> day == weekday end)
  end
  def find_day(weeks, weekday, :second) do
    7 + find_day(weeks, weekday, :first)
  end
  def find_day(weeks, weekday, :third) do
    7 + find_day(weeks, weekday, :second)
  end
  def find_day(weeks, weekday, :fourth) do
    7 + find_day(weeks, weekday, :third)
  end
  def find_day(weeks, weekday, :teenth) do
    Enum.find([find_day(weeks, weekday, :third),
    find_day(weeks, weekday, :second)], fn(x) ->
      x > 11 && x < 19
    end)

  end
  def find_day(weeks, weekday, :last) do
    in_last_week = length(weeks) == 5 && Enum.find(Enum.at(weeks, 4), fn(d)-> d == weekday end)
    cond do
      in_last_week -> 28 + find_day(Enum.at(weeks, 4), weekday)
      true -> 21 + find_day(Enum.at(weeks, 3), weekday)
    end
  end
end
