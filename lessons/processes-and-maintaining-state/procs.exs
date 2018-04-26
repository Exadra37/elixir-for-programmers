defmodule Procs do

  @doc """
  # Spawning a Process

  The function spawn will be used:

    → spawn(Module, Function, Arguments)

  In Elixir world we may see MFA that stands for Module Function Arguments.


  #### Example:

  iex> iex(21)> spawn Procs, :greeter, ["world"]
  #PID<0.289.0>
  Hello world
  """
  def greeter(count) do
    receive do
      { :boom, reason } ->
        exit(reason)
      { :add, n } ->
        greeter(count+n)
      :reset ->
        greeter(0)
      msg ->
        IO.puts "#{count}: Hello #{inspect msg}"
        greeter(count)
    end
  end

end
