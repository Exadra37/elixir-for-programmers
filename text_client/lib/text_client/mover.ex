defmodule TextClient.Mover do

  alias TextClient.State

  def make_move(text_client_state = %State{}) do
    tally = Hangman.make_move(text_client_state.game_pid, text_client_state.guess)
    %State{ text_client_state | tally: tally }
  end

end
