defmodule EvenLength do

  @moduledoc """
  # List Even Length?

  Module to check if a given lis as an even length.

  This is an exercise that we can found [here](https://codestool.coding-gnome.com/courses/take/elixir-for-programmers/texts/1554976-lists-and-recursion#more-complex-patterns).

  No solution link provided for this exercise.
  """

  @doc """
  ## is_even/1 - Used when the given list is empty.

  Does not use recursion but is an exit point for when recursion is being used.

  #### Example:

  iex> EvenLength.is_even([])
  false
  """
  def is_even([]) do
      false
  end

  @doc """
  ## is_even/1 - Used when the given list as only 1 element.

  Does not use recursion but is an exit point for when recursion is being used.

  #### Example:

  iex> EvenLength.is_even([1])
  false
  """
  def is_even([ _head | [] ]) do
    false
  end

  @doc """
  ## is_even/1 - Used when the given list as only 2 elements.

  Does not use recursion but is an thruthy exit point for when recursion is being used.

  #### Example:

  iex> EvenLength.is_even([1,2])
  true
  """
  def is_even([ _head, _head2 | [] ]) do
    true
  end

  @doc """
  ## is_even/1 - Used when the given list as 3 or more elements.

  It will use recursion to check if the list is even.

  #### Examples:

  iex> EvenLength.is_even([1,2,3])
  false

  iex> EvenLength.is_even([1,2,3,4])
  true

  iex>EvenLength.is_even([1,2,3,4,5])
  false
  """
  def is_even([ _head, _head2 | tail ]) do
    is_even(tail)
  end

end