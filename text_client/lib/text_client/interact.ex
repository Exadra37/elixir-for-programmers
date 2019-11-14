defmodule TextClient.Interact do

  @hangman_server :hangman@hangman

  alias TextClient.{Player, State}

  def start() do
    new_game()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state(game_pid) do
    %State{
      game_pid: game_pid,
      tally: Hangman.tally(game_pid),
    }
  end

  defp new_game() do
    Node.connect(@hangman_server)
    :rpc.call(@hangman_server, Hangman, :new_game, [])
  end

end
