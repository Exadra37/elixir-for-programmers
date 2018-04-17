defmodule TextClient.Summary do

  def display(game = %{ tally: tally }) do
    IO.puts [
      "\n",
      "Word so far: #{Enum.join(tally.letters, " ")}\n",
      "Guesses left: #{tally.turns_left}\n",
      "Letters used: #{tally.used}\n",
    ]

    game
  end

end
