defmodule Chain do

  @moduledoc """
  # Lesson: Nodes and Distributed Elixir > Implementing a Chain

  For this we will need to open 4 terminals in dir:

  * `./lessons/nodes-and-distributed-elixir/implementing-the-chain`

  > NOTE: When in Docker all 4 terminals must be on the same container.

  Now in each terminal we need to run:

  ```
  iex --sname node1 chain.exs
  ```
  Do not forget to replace in each terminal  `node1` by `node2`, etc. .

  In each node IEX shell run we need to start the Chain process...

  IEX Shell for node1:

  ```
  iex(node1@fcbf5a57b69f)1> Chain.start_link :node2@fcbf5a57b69f, 5000

  ---> READY TO PROCESS 5000 MESSAGES <---

  true
  ```

  IEX Shell for node2:

  ```
  iex(node2@fcbf5a57b69f)1> Chain.start_link :node3@fcbf5a57b69f, 5000

  ---> READY TO PROCESS 5000 MESSAGES <---

  true
  ```

  IEX Shell for node3:

  ```
  iex(node3@fcbf5a57b69f)1> Chain.start_link :node4@fcbf5a57b69f, 5000

  ---> READY TO PROCESS 5000 MESSAGES <---

  true
  ```

  IEX Shell for node4:

  ```
  iex(node4@fcbf5a57b69f)1> Chain.start_link :node1@fcbf5a57b69f, 5000

  ---> READY TO PROCESS 5000 MESSAGES <---

  true
  ```

  Back to IEX Shell for node1:

  ```
  iex(node1@fcbf5a57b69f)2> send :chainer, { :trigger, [] }

  → Starting tp process 5000 at 17:27:00.440324

  {:trigger, []}
  ```

  After some seconds we will see in each node terminal, something like:

  ```
             Messages Sent: 5000
         Processing Time: 14.55972 seconds
Messages Sent per Second: 343
Average time per message: 0.002911944 seconds
              Start Time: 18:58:48.902116
                End Time: 18:59:03.461836

  ```

  """

  defstruct(
    next_node:     nil,
    start_time:    nil,
    initial_count: 4,
    final_count:   4,
  )

  def start_link(next_node) do
    %Chain{
      next_node: next_node,
      start_time: Time.utc_now(),
    }
    |> _start_link()
  end

  def start_link(next_node, count) do
    %Chain{
      next_node: next_node,
      initial_count: count,
      final_count: count,
    }
    |> _start_link()
  end

  defp _start_link(chain) do
    IO.puts "\n---> READY TO PROCESS #{chain.initial_count} MESSAGES <---\n"

    spawn_link(Chain, :message_loop, [ chain ])
    |> Process.register(:chainer)
  end

  def message_loop(chain = %{ final_count: 0 }) do
    output_result(chain)
  end

  def message_loop(chain) do
    receive do
      { :trigger, list } ->
        new_chain = init_timer(chain)
        send { :chainer, new_chain.next_node }, { :trigger, [ node() | list ] }
        message_loop(%{ new_chain | final_count: new_chain.final_count - 1 })
    end
  end

  defp init_timer(chain = %{ start_time: nil }) do
    start_time = Time.utc_now()

    IO.puts "\n→ Starting tp process #{chain.initial_count} at #{start_time}\n"

    %{ chain | start_time: start_time }
  end

  defp init_timer(chain) do
    chain
  end

  defp output_result(chain) do
    start_time = chain.start_time
    end_time = Time.utc_now()
    time_diff = Time.diff(end_time, start_time, :microseconds)
    time_diff_seconds = time_diff / 1_000_000
    average_time_per_message = time_diff_seconds / chain.initial_count
    messages_sent_per_second = chain.initial_count / time_diff_seconds |> round

    IO.puts """

               Messages Sent: #{chain.initial_count}
             Processing Time: #{time_diff_seconds} seconds
    Messages Sent per Second: #{messages_sent_per_second}
    Average time per message: #{average_time_per_message} seconds
                  Start Time: #{start_time}
                    End Time: #{end_time}

    """
  end

end
