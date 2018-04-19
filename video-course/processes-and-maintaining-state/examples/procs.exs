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
  def greeter(name) do

    # just for demo purposes, almost never used in production code
    Process.sleep 1000

    IO.puts "Hello #{name}"
  end

end
