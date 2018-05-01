defmodule TextClient.Interact do

  alias TextClient.{Player, State}

  def start() do
    Hangman.new_game()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state(game_pid) do
    %State{
      game_pid: game_pid,
      tally: Hangman.tally(game_pid),
    }
  end

end
