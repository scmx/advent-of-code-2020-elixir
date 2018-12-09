defmodule Adventofcode.Circle do
  @moduledoc """
  Circle is a circular data structure.

  It's implemented using a map where every value is a three-element tuple
  containing the id of the previous item, the value of the current item and then
  the id of the next item.

  There are also meta-keys like size, current and counter that are kept up to
  date automatically as long as the built in API functions are used.
  """
  def new do
    %{size: 0, current: 0, counter: 0}
  end

  def to_list(state) do
    []
    |> do_to_list(state, state.current, state.current)
    |> Enum.reverse()
  end

  defp do_to_list(list, _state, current, current) when length(list) > 0 do
    list
  end

  defp do_to_list(list, state, current, last) do
    {_, value, next} = state[current]
    do_to_list([value | list], state, next, last)
  end

  def size(state) do
    state.size
  end

  def current(%{size: 0}), do: nil

  def current(state) do
    elem(state[state.current], 1)
  end

  def move_next(state) do
    {_, _, next} = state[state.current]

    Map.put(state, :current, next)
  end

  def move_prev(state) do
    {prev, _, _} = state[state.current]

    Map.put(state, :current, prev)
  end

  def insert_next(%{size: 0} = state, value) do
    id = state.counter + 1

    do_insert_next(state, id, {id, value, id})
  end

  def insert_next(state, value) do
    id = state.counter + 1

    prev = state.current
    {_, _, next} = state[state.current]

    do_insert_next(state, id, {prev, value, next})
  end

  defp do_insert_next(state, id, {prev, _value, next} = item) do
    state
    |> Map.put(id, item)
    |> Map.put(:current, id)
    |> Map.update(prev, item, &put_elem(&1, 2, id))
    |> Map.update(next, item, &put_elem(&1, 0, id))
    |> Map.update(:size, 0, &(&1 + 1))
    |> Map.update(:counter, 0, &(&1 + 1))
  end

  def remove_current(%{size: 0} = state), do: state

  def remove_current(state) do
    {prev, _, next} = state[state.current]

    state
    |> Map.update(prev, nil, &put_elem(&1, 2, next))
    |> Map.update(next, nil, &put_elem(&1, 0, prev))
    |> Map.put(:current, next)
    |> Map.update(:size, 0, &(&1 - 1))
    |> Map.delete(state.current)
  end
end
