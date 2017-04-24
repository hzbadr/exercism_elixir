defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep(list, fun) do
    case list do
      [] -> []
      _ -> keep(hd(list), tl(list), fun)
    end
  end

  def keep(h, [], fun) do
    if fun.(h) do
      [h]
    else
      []
    end
  end

  def keep(h, list, fun) do
    [x | t] = list
    if fun.(h) do
      [h | keep(x, t, fun)]
    else
      keep(x, t, fun)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard(list, fun) do
    list -- keep(list, fun)
  end
end
