defmodule TextClient.Player do

  alias TextClient.{Mover, Prompter, Summary, State}

  def play(game = %State{tally: %{ game_state: :won }}) do
    IO.puts "\nWORD: #{Enum.join(game.game_service.letters, "")}"
    exit_with_message("You WON!")
  end

  def play(game = %State{tally: %{ game_state: :lost }}) do
    exit_with_message("\nSorry, you lost...\nWord was: #{Enum.join(game.game_service.letters, "")}")
  end

  def play(game = %State{tally: %{ game_state: :good_guess }}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{tally: %{ game_state: :bad_guess }}) do
    continue_with_message(game, "Sorry, that isn't in the word...")
  end

  def play(game = %State{tally: %{ game_state: :already_used }}) do
    continue_with_message(game, "You've already used that letter...")
  end

  def play(game) do
    continue(game)
  end

  def continue_with_message(game, message) do
    IO.puts(message)
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.move()
    |> play()
  end

  defp exit_with_message(msg) do
    IO.puts [
      msg,
      "\n"
    ]

    exit(:normal)
  end

end
