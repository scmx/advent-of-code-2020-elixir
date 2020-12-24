defmodule Adventofcode.Circle do
  @moduledoc """
  Circle is a circular data structure.

  It's implemented using a map where every value is a three-element tuple
  containing the id of the previous item, the value of the current item and then
  the id of the next item.

  There are also meta-keys like size, current and counter that are kept up to
  date automatically as long as the built in API functions are used.
  """
  def new(values \\ []) do
    values
    |> Enum.reduce(%{size: 0, current: 0, counter: 0}, &insert_next(&2, &1))
    |> move_next
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

  def all(state) do
    state
    |> Map.delete(:size)
    |> Map.delete(:current)
    |> Map.delete(:counter)
    |> Enum.map(fn {id, {_, val, _}} -> {id, val} end)
  end

  def size(state) do
    state.size
  end

  def current(%{size: 0}), do: nil

  def current(state) do
    elem(state[state.current], 1)
  end

  def at(state, id) do
    {_, val, _} = state[id]
    val
  end

  def move_next(state) do
    {_, _, next} = state[state.current]

    Map.put(state, :current, next)
  end

  def move_prev(state) do
    {prev, _, _} = state[state.current]

    Map.put(state, :current, prev)
  end

  def insert_after(state, values), do: insert_after(state, values, state.current)

  def insert_after(state, values, after_id) when is_list(values) do
    values
    |> Enum.reduce({state, after_id}, fn value, {acc, prev} ->
      id = acc.counter + 1
      {_, _, next} = acc[prev]

      {do_insert(acc, id, {prev, value, next}), id}
    end)
    |> elem(0)
  end

  def insert_next(state, values) when is_list(values) do
    values
    |> Enum.reduce(state, &insert_next(&2, &1))
  end

  def insert_next(%{size: 0} = state, value) do
    id = state.counter + 1

    state
    |> do_insert(id, {id, value, id})
    |> Map.put(:current, id)
  end

  def insert_next(state, value) do
    id = state.counter + 1

    prev = state.current
    {_, _, next} = state[state.current]

    state
    |> do_insert(id, {prev, value, next})
    |> Map.put(:current, id)
  end

  defp do_insert(state, id, {prev, _value, next} = item) do
    state
    |> Map.put(id, item)
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

  def take_after(state, amount) when is_integer(amount) and amount >= 1 do
    {result, state} = Enum.reduce(1..amount, {[], move_next(state)}, &do_take/2)
    {result, move_prev(state)}
  end

  defp do_take(_, {result, state}) do
    {result ++ [current(state)], remove_current(state)}
  end
end
