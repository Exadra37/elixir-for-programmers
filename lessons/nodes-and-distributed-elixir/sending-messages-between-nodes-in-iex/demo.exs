defmodule Demo do

  @moduledoc """
  # Lesson: Nodes and Distributed Elixir > Sending Messages Between Nodes in IEX

  We need to open 2 IEX terminals...

  > NOTE: When in Docker all 4 terminals must be on the same container.

  From terminal:

  ```
  iex --sanme node1
  ```

  From another terminal window:

  ```
  iex --sname node2
  ```

  ## Sending a message and receiving a reply for it on an IEX shell

  iex(node2@fcbf5a57b69f)1> c "lessons/nodes-and-distributed-elixir/sending-messages-between-nodes-in-iex/demo.exs"
  [Demo]
  iex(node2@fcbf5a57b69f)50> Demo.spawn :reverse_with_reply
  :reverse_with_reply

  iex(node1@fcbf5a57b69f)1> send { :reverse_with_reply, :node2@fcbf5a57b69f }, { self(), "exadra37" }
  {#PID<0.91.0>, "exadra37"}
  iex(node1@fcbf5a57b69f)2> flush
  "73ardaxe"
  :ok

  #PID<9936.91.0>
  iex(node2@fcbf5a57b69f)55>

  """

  @doc """
  ### Spawning a process for a Demo function

  iex> Demo.spawn :reverse_with_reply
  """
  def spawn(function_name) do
    spawn __MODULE__, function_name, []
    |> Process.register function_name

    function_name
  end

  @doc """
  Receives a message, reverses it and prints the result.
  """
  def reverse() do
    receive do
      msg  ->
        result = msg |> String.reverse
        IO.puts result
        reverse()
    end
  end

  @doc """
  Receives a message, reverses it and send back the reply to the origin with result.
  """
  def reverse_with_reply() do
    receive do
      { from_pid, msg } ->
        IO.puts inspect from_pid
        result = msg |> String.reverse
        send from_pid, result
        reverse_with_reply()
    end
  end

end
