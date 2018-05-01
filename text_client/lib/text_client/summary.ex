defmodule TextClient.Summary do

  alias TextClient.State

  def display(text_client_state = %State{ tally: tally }) do
    IO.puts [
      "\n",
      "Word so far: #{Enum.join(tally.letters, " ")}\n",
      "Guesses left: #{tally.turns_left}\n",
      "Letters used: #{tally.used}\n",
    ]

    text_client_state
  end

end
