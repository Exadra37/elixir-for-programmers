defmodule TextClient.Player do

  alias TextClient.{Mover, Prompter, Summary, State}

  def play(%State{tally: %{ game_state: :won , word: word}}) do
    IO.puts "\nWORD: #{word}"
    exit_with_message("You WON!")
  end

  def play(%State{tally: %{ game_state: :lost, word: word }}) do
    exit_with_message("\nSorry, you lost...\nWord was: #{word}")
  end

  def play(text_client_state = %State{tally: %{ game_state: :good_guess }}) do
    continue_with_message(text_client_state, "Good guess!")
  end

  def play(text_client_state = %State{tally: %{ game_state: :bad_guess }}) do
    continue_with_message(text_client_state, "Sorry, that isn't in the word...")
  end

  def play(text_client_state = %State{tally: %{ game_state: :already_used }}) do
    continue_with_message(text_client_state, "You've already used that letter...")
  end

  def play(text_client_state = %State{}) do
    continue(text_client_state)
  end

  def continue_with_message(text_client_state = %State{}, message) do
    IO.puts(message)
    continue(text_client_state)
  end

  def continue(text_client_state = %State{}) do
    text_client_state
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  def make_move(text_client_state = %State{}) do
    text_client_state
  end

  defp exit_with_message(msg) do
    IO.puts [
      msg,
      "\n"
    ]

    exit(:normal)
  end

end
