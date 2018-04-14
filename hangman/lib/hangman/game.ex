defmodule Hangman.Game do

  defstruct(
    turns_left: 7,
    game_state: :initialising,
    letters:    [],
    used:       [],
  )

  def new_game() do
    %Hangman.Game{
      letters: Dictionary.random_word |> String.codepoints
    }
  end

  def make_move(game = %{ game_state: state }, _guess) when state in [:won, :lost] do
    { game, tally(game) }
  end

  def make_move(game, guess) do
    game = accept_move(game, guess, Enum.member?(game.used, guess))
    { game, tally(game) }
  end

  def accept_move(game, _guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  def accept_move(game, guess, _already_guessed) do
    Map.put(game, :used, [ guess | game.used ])
  end


  def tally(_game) do
    123
  end

end
