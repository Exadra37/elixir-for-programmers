defmodule Hangman.Server do

  alias Hangman.Game

  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_args) do
    { :ok, Game.new_game() }
  end

  def handle_call({ :make_move, guess }, _from, game) do
    { game, tally } = Game.make_move(game, guess)

    # { :reply, response, new_state }
    { :reply, tally, game }
  end

end
