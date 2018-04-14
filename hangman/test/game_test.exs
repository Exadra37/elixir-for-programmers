defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do

    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initialising
    assert length(game.letters) > 0

    # your turn task
    assert game.letters |> to_string()  =~ ~r{^[a-z]+\z}

  end

  test "state isn't changed for :won game" do

    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert { ^game, _ } = Game.make_move(game, "x")
    end

  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()

    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is not already used" do
    game = Game.new_game()

    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state != :already_used

    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

end
